Purpose: Demonstrates real-world Active Directory account lockout troubleshooting and resolution in an enterprise Windows environment.

![Windows](https://img.shields.io/badge/OS-Windows-blue)
![Lab](https://img.shields.io/badge/Project-Home%20Lab-purple)
![Ticketing](https://img.shields.io/badge/Ticketing-informational)
![Troubleshooting](https://img.shields.io/badge/Troubleshooting-success)
![Caution](https://img.shields.io/badge/⚠️-Administrative%20Changes-critical)

# Ticket ID: INC-2026-001 (Account Lockout)

## Issue:
End user is reporting their inability to autenticate to their Windows 10 Enterprise workstation, receiving an account locked status during several login attempts.

## User Impact:
User is unable to access key company resources; such as email (Exchange Online), shared network drives (SMB Shares), and Internal business applications. This outage is causing major business disruptions for the user, and because of this, prevents the user from performing time-sensitive critical job functions, resulting in this incident being classified as a P1.

## Environment:
- Location: 2nd Floor Sales Department, Workstation C-201
- Windows 10 Enterprise  
- Network Services: Active Directory Domain Services (AD DS)
- Affected User Principal Name: a.smith@lablocal.com

## Troubleshooting & Diagnostics
1. Confirmed user-reported error state locally at the workstation GUI.
2. Validated account lockout status within the Active Directory Users and Computers (ADUC) console via a Domain Controller (DC) session.
3. Reviewed the user's recently failed login attempts (Bad_Pwd_Count), and took a look at some recent security logs to determine the source of the lockout.
4. Confirmed that the account and lockout settings complied with the companies policies.

## Root Cause
User exceeded the configured account lockout threshold (4 failed login attempts) within the defined policy window, triggering an automatic security lockout enforced by the domain’s Group Policy.

## Resolution
- Unlocked the user's Active Directory account using administrative tools (ADUC / Powershell)
- Worked with the user to identify and verify the correct login credentials are now used to prevent another lockout
- Verified successful login and restored access by confirming authentication events in security logs.  
## Prevention / Best Practices
- Educate user on proper credential practices and recommended verifying login information before attempting multiple sign-ins to prevent account lockouts in the future. 
- Also recommended utilizing the enterprise-approved password manager solution to mitigate future entry errors and forgotten credentials.