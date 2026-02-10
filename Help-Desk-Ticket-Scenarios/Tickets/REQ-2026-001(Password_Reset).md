Purpose: Demonstrates secure management of user credentials, including multi-factor identity verification, enforcement of corporate password complexity policies, and proactive account security measures.

![Windows](https://img.shields.io/badge/OS-Windows-blue)
![Lab](https://img.shields.io/badge/Project-Home%20Lab-purple)
![Ticketing](https://img.shields.io/badge/Ticketing-informational)
![Troubleshooting](https://img.shields.io/badge/Troubleshooting-success)
![Caution](https://img.shields.io/badge/⚠️-Administrative%20Changes-critical)

# Ticket ID: REQ-2026-001 (Password_Reset)

## Issue 
User reported a password reset after forgetting their domain password for their user account.

## User Impact
User cannot log in to their workstation or access company resources.

## Environment 
- Location: 2nd Floor Marketing Department 
- Authentication Protocol: Active Directory Domain Services (AD DS)
- Affected User Principal Name: (Internal Support Ticket)

## Troubleshooting & Diagnostics
1. Confirmed user's identity per support procedure.
2. Checked password policy requirements in Active Directory.
3. Initiated password reset using administrative tools (ADUC / Powershell).
4. Ensured "User must change password at next logon" was enabled.

## Root Cause 
User exceeded the configured password expiration policies/ or forgot their domain credentials. 

## Resolution
1. Reset the password in Active Directory.
2. Instructed the user to change the password upon next login.
3. Confirmed successful login and password change by verifying authentication events in the security logs. 

## Prevention 
- Encouraged use of memorable, but strong passwords.
- Reminded user of password expiration policies
- Also recommended utilizing the enterprise-approved password manager solution to mitigate future entry errors and forgotten credentials.