# SentinelHealth Auditor v1.4
Automated System Monitoring & Infrastructure Reporting

## Project Overview
SentinelHealth is a PowerShell-based auditing suite designed to provide real-time visibility into workstation health. It bridges the gap between raw hardware data and actionable administrative alerts by generating localized HTML5 dashboards and remote cloud-based notifications.

## Key Features
- Instant Alerts: Configured the script to push JSON data to a Discord Webhook. This provides real-time notifications when a machine hits critical thresholds (like low disk space or high RAM), removing the need for manual log checks.
- Uptime Accuracy: Built a custom check for the "Fast Startup" (Hiberboot) registry key. This solves the common issue where Windows reports weeks of uptime even after a shutdown, so we can confirm if a system actually rebooted.
- Real-Time Metrics: Switched to Get-Counter samples for CPU tracking. By normalizing the data against the total number of processor cores, the report shows actual current load rather than inflated cumulative totals.
- Modern Reporting: Designed a sleek HTML/CSS dashboard for local reporting. I wanted the data to be easy to read at a glance for both techs and managers.
- Portable Design: Used .NET environment classes for file pathing. This ensures the script runs without errors on systems with OneDrive-redirected Desktops or custom user profiles.

## AI Collaboration & Workflow
This project was developed in collaboration with AI, which served as a technical peer for:
- UI/UX Design: Refactoring raw HTML output into a high-contrast CSS dashboard for better readability.
- Troubleshooting: Identifying character encoding issues (UTF-8) that caused rendering hangs in specific browsers.
- Optimization: Refining complex PowerShell logic for real-time resource sampling.

## How to Use 
1. Configure: Add your Webhook URL to the $WebhookUrl variable in the script found [here](https://github.com/water-fountain/Portfolio/blob/main/SentinelHealth-Auditor/SentinelHealth.ps1).

2. Run: Execute the script in PowerShell (requires Administrator privileges for registry and service checks).

3. Review: Check your Desktop for the SentinelHealth_Report.html and your designated Discord channel for the alert.