# Windows Locked Out Recovery Guide

![Windows](https://img.shields.io/badge/OS-Windows-blue)
![Lab](https://img.shields.io/badge/Project-Home%20Lab-purple)
![Warning](https://img.shields.io/badge/⚠️-Caution-red)
![Caution](https://img.shields.io/badge/⚠️-Administrative%20Changes-critical)

> **Warning:** This method involves replacing system files. Use only on a Personal PC. Remember, back up important data if possible.

---

## Goal
Regain access to Windows / Windows AD if you are locked out due to a forgotten password using the `utilman.exe` workaround.

---

## Steps

<details>
<summary>1. Boot Into Recovery Mode</summary>

1. Insert a Windows installation USB or DVD. (https://www.microsoft.com/en-us/software-download/windows11)
2. Boot from the USB/DVD.
3. Select **Repair your computer → Troubleshoot → Advanced options → Command Prompt**.

</details>

<details>
<summary>2. Identify Your Windows Drive</summary>

1. At the Command Prompt, type:

```cmd
diskpart
list volume
exit
```

2. Identify the drive letter where Windows is installed (commonly `C:` or `D:` in recovery mode).

</details>

<details>
<summary>3. Backup `utilman.exe`</summary>

1. Run:

```cmd
C:\Windows\System32\utilman.exe C:\Windows\System32\utilman.exe.bak
```

*(Replace `C:` with your personal Windows drive if different.)*

2. Confirm overwrite if prompted, then (type `Yes`).

</details>

<details>
<summary>4. Replace `utilman.exe` With Command Prompt</summary>

1. Run:

```cmd
C:\Windows\System32\cmd.exe C:\Windows\System32\utilman.exe
```

2. Confirm overwrite if prompted.

</details>

<details>
<summary>5. Reboot and use the Fix</summary>

1. Restart your computer as you normally would.
2. On the login screen, click the **Ease of Access** button at the bottom-right corner. This will open a Command Prompt with administrative privileges, instead of the previous controls.

</details>

<details>
<summary>6. Reset Your Password</summary>

1. In the Command Prompt, type:

```cmd
net user <username> <newpassword>
```

- Replace `<username>` with your Windows account name.
- Replace `<newpassword>` with a new password.

2. Close the Command Prompt and log in with the new password.

</details>

<details>
<summary>7. Restore Original `utilman.exe`</summary>

1. After logging in, restore the original file:

```cmd
copy C:\Windows\System32\utilman.exe.bak C:\Windows\System32\utilman.exe
```

2. Confirm overwrite.

</details>

---

## Forced Restore Fix (If Errors Occur)

**If an error does occur:** 

You should run a forced restore:

<details>
<summary>Step 1: Take ownership</summary>

```cmd
takeown /f C:\Windows\System32\utilman.exe
```
</details>

<details>
<summary>Step 2: Grant yourself full permissions</summary>

```cmd
icacls C:\Windows\System32\utilman.exe /grant administrators:F
```
</details>

<details>
<summary>Step 3: Restore the original file</summary>

```cmd
copy C:\Windows\System32\utilman.exe.bak C:\Windows\System32\utilman.exe
```
</details>

<details>
<summary>Step 4: Reset PC & Check Ease of Access Controls</summary>

</details>

## How It Works
The Windows login screen allows certain accessibility tools—like Utility Manager (`utilman.exe`)—to run *before* a user signs in fully. By temporarily replacing `utilman.exe` with `cmd.exe`, Windows unknowingly grants you a Command Prompt with system-level privileges at the login screen. Letting you bypass knowing your password, in order to let you reset passwords or enable accounts without normal login authentication.

---

### Notes
- Only works for local accounts. Microsoft accounts may require additional steps.
- Do **not** use this method on systems you do not own, as it is a breach of privacy.
- Always restore `utilman.exe` to maintain system security, as others can do the same to your own devices.

---

*Created by [B. Fontaine] — Use responsibly & at your own risk.*

