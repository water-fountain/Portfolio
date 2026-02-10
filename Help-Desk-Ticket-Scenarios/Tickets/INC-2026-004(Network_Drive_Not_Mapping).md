Purpose: Demonstrates resolution of mapped network drive issues through Active Directory group management, Group Policy analysis, and SMB file share troubleshooting.

![Windows](https://img.shields.io/badge/OS-Windows-blue)
![Lab](https://img.shields.io/badge/Project-Home%20Lab-purple)
![Ticketing](https://img.shields.io/badge/Ticketing-informational)
![Troubleshooting](https://img.shields.io/badge/Troubleshooting-success)
![Caution](https://img.shields.io/badge/⚠️-Administrative%20Changes-critical)

# Ticket ID: INC-2026-004 (Network Drive not Appearing)

# Issue:
End User reports that a previously accessible mapped network drive is no longer appearing in the File Explorer. The user is able to successfully sign into Windows & access other resources; but, required department shared files are inaccessible, impacting daily work tasks and routines. 

# User Impact:
The User's inability to access the shared network resources is totally preventing them from editing, opening, and even saving critical files stored on internal servers. This disruption affects mostly collaboration and productivity, so this would be classified around a P2.  

# Environment:
Location: 3rd Floor Finance Department, Workstation F-307
Operating System: Windows 10 Enterprise
Network Services: Active Directory Domain Services (AD DS), SMB File Shares
File Server: FS-01.lablocal.com
Affected User Principal Name: j.martin@lablocal.com

# Troubleshooting & Diagnostics:
1. Confirmed the missing network drive within File Explorer, and after confirming it missing, verfied whether or not the drive letter was present aswell, it was not.
2. Validated whether or not there was a successful domain authentication, and confirmed that the user had active network connectivity.
3. Attempted manual access using UNC path (`\\FS-01\Finance`), which failed.
4. Verified the user's group membership in AD and confirmed whether or not the security groups were correct for file share access.
5. Ontop of group verification, we reviewed NTFS & share permissions on the file server to make sure the user / group had appropriate access.
6. We also checked mapped drive configuration via the `net use` command to confirm the drive was not persistently mapped. 
7. Reviewed recent group policy updates, and verified successful GPO processing by using the command `gpresult /r`.    

# Root Cause
The mapped network drive relies on group policy targeting a particular Active Directory security group that the user was removed from. As a result, the drive was no longer mapped, causing the user during login to not see the shared drives.

# Resolution
- Restored the user's membership to the correct AD security group. 
- Forced a group policy update using `gpupdate /force`.
- Remapped the network drive via Group Policy and confirmed visibility within the file explorer.
- Verified successful access to the shared files and ensured permissions were correct for further use.

# Prevention / Best Practices
- Review group membership changes carefully while modifying user's roles or departments to ensure smooth shared access among users.
- Implement change documentation for any changes, so we can revert / prevent unitentional disruptions during working hours.
- Educate users on how to report missing resources promptly to minimize downtime and increase productivity and accessibility. 