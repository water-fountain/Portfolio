Purpose: Demonstrates layered network troubleshooting to isolate DNS resolution failures from underlying IP connectivity issues in a Windows enterprise environment.

![Windows](https://img.shields.io/badge/OS-Windows-blue)
![Lab](https://img.shields.io/badge/Project-Home%20Lab-purple)
![Ticketing](https://img.shields.io/badge/Ticketing-informational)
![Troubleshooting](https://img.shields.io/badge/Troubleshooting-success)
![DNS](https://img.shields.io/badge/Service-DNS-blue)
![Enterprise](https://img.shields.io/badge/Scenario-Enterprise%20Simulated-purple)
![Caution](https://img.shields.io/badge/⚠️-Administrative%20Changes-critical)

# Ticket ID: INC-2026-002 (No Internet Connectivity – DNS Resolution Failure)

## Issue:
End User reports loss of internet access on their Windows 10 Enterprise workstation. The User is able to sign into Windows successfully; however, upon further inspection, the external websites & internal networks were unreachable. This is also happening while applications relying on DNS resolution are failing to load up. 

## User Impact:
The User's inability to access external websites, cloud based services, and important internal buisness applications are impacting their ability to communicate and perfrom daily job functions within and outside the organization, classifying this incident as a P2. 

## Environment:
- Location: 1st Floor Operations Department, Workstation O-114
- Windows 10 Enterprise  
- Network Services: Active Directory Domain Services (AD DS), Internal DNS
- Affected User Principal Name: e.lato@lablocal.com

## Troubleshooting & Diagnostics
1. Confirmed lack of internet connectivity at the workstation by testing access to external and internal resources via web browser. (google chrome, mozilla firefox)
2. Verified physical network connection and confirmed workstation maintained an active Ethernet link.
3. Tested raw IP connectivity using `ping 8.8.8.8`, which succeeded, confirming network connectivity beyond the local subnet.
4. Tested hostname resolution using `nslookup` & `ping google.com`, which failed, indicating that it was a DNS related issue. 
5. Reviewed workstation DNS settings using `ipconfig /all` & identified incorrect DNS server entires not pointing to the domain DNS server.
6. Flushed the local DNS cache using `ipconfig /flushdns` & renewed IP address using `ipconfig /release` & `ipconfig /renew`.

## Root Cause
The workstation was configured with incorrect DNS server settings, preventing proper hostname resolution. This caused applications & browsers to fail despite underlying network connectivity being functional for other workstations around.

## Resolution
- Corrected the workstation's DNS server settings to point to the internl Active Directory DNS Server.
- Renewed the workstations's DHCP lease to ensure correct network parameters were applied.
- Vrification of successful DNS resolution by using `nslookup` & confirmed access to both internal & external resources. 
- Confirmed full internet connectivity by restoring and validating user access to the required applications. 

## Prevention / Best Practices
- Ensure workstations receive DNS settings automatically via DHCP to prevent misconfiguration in the future.
- Monitor & audit DHCP scope options to ensure correct DNS server distribution.
- Educate users to report connectivity issues promptly & to avoid manually modifying network settings / or physical hardware without IT approval.