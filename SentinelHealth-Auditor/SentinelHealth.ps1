<#
.info
    SentinelHealth: An auditing system and reporting tool for IT infrastructure.
.desc
    Gathers CPU, RAM, Disk, Uptime, and Process metrics. 
    Generates a HTML report and alerts via Discord Webhook.
#>

# CONFIG
$WebhookUrl = "Your-Webhook-Here"
$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$ReportPath = Join-Path -Path $DesktopPath -ChildPath "SentinelHealth_Report.html"
$Status = "Healthy"
$StatusColor = 65280 # Green (Decimal)

# 1. GATHER PC DATA (RAM, Disk, Boot-time, etc.) 
$CPUUsage = (Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
$RAM = Get-CimInstance Win32_OperatingSystem
$RAMTotal = [math]::Round($RAM.TotalVisibleMemorySize / 1MB, 2)
$RAMFree = [math]::Round($RAM.FreePhysicalMemory / 1MB, 2)
$RAMPercent = [math]::Round((($RAMTotal - $RAMFree) / $RAMTotal) * 100, 2)

$Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$DiskFreePercent = [math]::Round(($Disk.FreeSpace / $Disk.Size) * 100, 2)

$LastBoot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$UptimeSpan = (Get-Date) - $LastBoot
$UptimeString = "{0}d, {1}h, {2}m" -f $UptimeSpan.Days, $UptimeSpan.Hours, $UptimeSpan.Minutes
$HiberValue = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power").HiberbootEnabled
$FastStartupStatus = if ($HiberValue -eq 1) { "Enabled" } else { "Disabled" }
$ProcessCounter = Get-Counter '\Process(*)\% Processor Time' -ErrorAction SilentlyContinue
$TopProcesses = $ProcessCounter.CounterSamples | 
    Where-Object { $_.InstanceName -notmatch "^(_total|idle)$" -and $_.CookedValue -gt 0 } | 
    Sort-Object CookedValue -Descending | 
    Select-Object @{Name='Name'; Expression={$_.InstanceName}}, 
                  @{Name='CPU %'; Expression={[math]::Round(($_.CookedValue / $env:NUMBER_OF_PROCESSORS), 2)}} | 
    Select-Object -First 5
$SpoolerStatus = (Get-Service -Name "Spooler").Status

# 2. EVALUATE PC STATUS 
if ($DiskFreePercent -lt 15 -or $RAMPercent -gt 90) {
    $Status = "Critical"
    $StatusColor = 16711680 # Red (Decimal)
} elseif ($SpoolerStatus -ne "Running") {
    $Status = "Warning"
    $StatusColor = 16776960 # Yellow (Decimal)
}

# 3. HTML REPORT
$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$ReportPath = Join-Path -Path $DesktopPath -ChildPath "SentinelHealth_Report.html"

# CSS
$HTMLHeader = @"
<html>
<head>
<style>
    body { background: #0f172a; color: #f8fafc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 40px; }
    .container { max-width: 900px; margin: auto; background: #1e293b; padding: 30px; border-radius: 12px; box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.5); border-left: 8px solid $(if($Status -eq 'Healthy'){'#22c55e'}else{'#ef4444'}); }
    h1 { margin-top: 0; color: #f1f5f9; border-bottom: 1px solid #334155; padding-bottom: 10px; }
    .meta-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; background: #334155; padding: 15px; border-radius: 8px; }
    .meta-item b { color: #94a3b8; text-transform: uppercase; font-size: 0.8rem; display: block; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; background: #0f172a; border-radius: 8px; overflow: hidden; }
    th { background: #475569; color: #f8fafc; text-align: left; padding: 12px; font-size: 0.9rem; }
    td { padding: 12px; border-bottom: 1px solid #1e293b; font-size: 0.95rem; }
    tr:last-child td { border-bottom: none; }
    .status-pill { padding: 4px 12px; border-radius: 20px; font-weight: bold; font-size: 0.85rem; background: $(if($Status -eq 'Healthy'){'#14532d'}else{'#7f1d1d'}); color: $(if($Status -eq 'Healthy'){'#4ade80'}else{'#f87171'}); }
</style>
</head>
<body>
<div class="container">
"@

$HTMLBody = @"
    <h1>SentinelHealth Auditor <span class="status-pill">$Status</span></h1>
    <div class="meta-grid">
        <div class="meta-item"><b>System Uptime</b>$UptimeString</div>
        <div class="meta-item"><b>Fast Startup Status</b>$FastStartupStatus</div>
    </div>
    
    <table>
        <thead><tr><th>Metric</th><th>Current Value</th></tr></thead>
        <tbody>
            <tr><td>CPU Usage</td><td>$CPUUsage%</td></tr>
            <tr><td>RAM Usage</td><td>$RAMPercent%</td></tr>
            <tr><td>Available Storage (C:)</td><td>$DiskFreePercent%</td></tr>
            <tr><td>Print Spooler Service</td><td>$SpoolerStatus</td></tr>
        </tbody>
    </table>

    <h3 style="margin-top:30px; color:#94a3b8;">Resource Intensive Processes</h3>
    $($TopProcesses | ConvertTo-Html -Fragment)
"@

$HTMLFooter = "</div></body></html>"

# UTF8 to prevent browser hangs
$HTMLHeader + $HTMLBody + $HTMLFooter | Out-File -FilePath $ReportPath -Encoding utf8

# 4. DISCORD WEBHOOK
$Payload = @{
    embeds = @(@{
        title = "System Health Alert: $Status"
        color = $StatusColor
        description = "Report generated for **$env:COMPUTERNAME**"
        fields = @(
            @{ name = "CPU Usage"; value = "$CPUUsage%"; inline = $true }
            @{ name = "RAM Usage"; value = "$RAMPercent%"; inline = $true }
            @{ name = "C: Free Space"; value = "$DiskFreePercent%"; inline = $true }
            @{ name = "Uptime"; value = $UptimeString; inline = $true }
            @{ name = "Fast Startup"; value = $FastStartupStatus; inline = $true }
        )
        footer = @{ text = "SentinelHealth Auditor v1.4" }
    })
}

Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body ($Payload | ConvertTo-Json -Depth 4) -ContentType 'application/json'

Write-Host "Report generated and alert sent. Status: $Status" -ForegroundColor Cyan