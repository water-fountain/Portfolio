Purpose: Demonstrates troubleshooting of DHCP-related network failures, identification of APIPA address conditions, and restoration of network connectivity in a Windows enterprise environment.

![Windows](https://img.shields.io/badge/OS-Windows-blue)
![Lab](https://img.shields.io/badge/Project-Home%20Lab-purple)
![Ticketing](https://img.shields.io/badge/Ticketing-informational)
![Troubleshooting](https://img.shields.io/badge/Troubleshooting-success)
![Caution](https://img.shields.io/badge/⚠️-Administrative%20Changes-critical)

# Ticket ID: INC-2026-003 (No Network Connectivity – APIPA Address)

# Issue:
User m.jones@lablocal.com (Finance, 3rd Floor) reported a total network blackout. The workstation was completely isolated—no email, no shared drives, and no internet access. The workstation displays a self-assigned IP address (169.254.x.x).

# User Impact:
User is unable to access email, shared network drives, internal applications, and even the internet. This problem prevents the user from performing core job responsibilities and results in significant productivity loss. Given the impact on Finance operations, we treated this as a P1 incident.

# Environment:
Location: 3rd Floor Finance Department, Workstation F-308
Operating System: Windows 10 Enterprise
Network Services: Active Directory Domain Services (AD DS), DHCP, DNS
Affected User Principal Name: m.jones@lablocal.com

# Troubleshooting & Diagnostics:
1. Verified network connectivity issue at the workstation, and identified a (169.254.x.x) APIPA address using `ipconfig` on this specific workstation.
2. Confirmed physical network connection and verified Ethernet link status at the NIC & switch port.
3. Attempted DHCP lease renewal using `ipconfig /release` and `ipconfig /renew`, which failed to obtain a valid IP address.
4. Tested connectivity on a neighboring workstation connected to the same switch, confirming normal network operation.
5. Reviewed DHCP server status and scope availability on the DC (domain controller).
6. Identified the affected workstation’s switch port was assigned to an incorrect VLAN, preventing access to the DHCP server.

# Root Cause
The workstation’s network switch port was assigned to an incorrect VLAN, preventing DHCP communication. As a result, the workstation created a "dead end" to where the workstation itself couldn't communicate with the DHCP server, forcing Windows to default onto an APIPA address.

# Resolution
- Reassigned the workstation’s switch port to the correct VLAN with access to the DHCP server.
- Released and renewed the DHCP lease to obtain a valid IP address.
- Verified proper IP assignment, DNS resolution, and successful authentication to the domain controller.
- Confirmed restoration of network and application access with the user. (mapped drives / outlook services)

# Prevention / Best Practices
- Implement switch port documentation and labeling to reduce VLAN assignment errors.
- Monitor DHCP lease failures to proactively identify network segmentation issues.
- Educate support staff on recognizing APIPA addresses as indicators of DHCP-related failures. It could be a hint for "VLAN or Scope" problems.