# Forgotten Your Windows Password? Here's How to Break Back In
![Feature Article](https://img.shields.io/badge/Article-Feature-informational)
![How-To Guide](https://img.shields.io/badge/Article-How--To-success)
![Hardware](https://img.shields.io/badge/Focus-Hardware-orange)
![Networking](https://img.shields.io/badge/Focus-Networking-blue)
![Home Lab](https://img.shields.io/badge/Focus-Home%20Lab-lightgrey)
![Technical Writing](https://img.shields.io/badge/Skill-Technical%20Writing-brightgreen)
![UX Writing](https://img.shields.io/badge/Skill-UX%20Writing-purple)
![Research-Based](https://img.shields.io/badge/Style-Research%20Driven-blueviolet)

> **Warning**: You should only perform this on a PC that you own, and always ensure your important data is backed up before tinkering with any data.

Getting locked out of your computer is a rite of passage for everyone, not just "tech people." It might be an old laptop you found in the back of a closet or a forgotten admin account for the family PC. Whatever the case may be, hitting that "Incorrect Password" error over and over again feels like a dead end when you’ve exhausted every other avenue. But before you give up and delete all your precious files, there’s a classic workaround you might not have heard of. It’s a bit of a "backdoor" trick, but by utilizing the **Windows Recovery Environment** to swap the **Ease of Access utility** for the **Command Prompt**, you effectively bypass the lock screen—allowing you to reset your credentials and get back to work within minutes without losing any important data.

## What You'll Need

* A Windows Installation USB or DVD [(you can download the tool from Microsoft here)](https://www.microsoft.com/en-us/software-download/windows11).
* **10–15 Minutes**: This is a quick fix, provided you're comfortable typing a few lines of code into the Command Prompt.

## Step 1: Boot Into the Recovery Environment
To perform this 'brain surgery' on your OS, we need to access the system files while Windows isn't actually running. This requires booting from an external media source so that your hard drive is 'at rest' and the files aren't currently in use by the system.

1. **Plug and Reboot**: Insert your Windows Installation USB or DVD into your device and restart it. 
2. **Hit the Boot Menu**: As your PC starts up, before the Windows or motherboard logo appears, you'll need to tap your boot menu key repeatedly. These are usually **F12**, **F11**, or **Esc**. From the menu that appears, select your USB drive as the primary boot device.
3. **The "Secret" Path**: Once the Windows installer screen loads, **do not** click the "**Install Now**" button. Instead, look for the small **Repair your computer** link tucked away in the bottom-left corner.
4. **Navigate the Menus**: Follow this path to open your recovery toolkit :

**Troubleshoot → Advanced options → Command Prompt**.

## Step 2: Locate Your Windows Installation
Once Command Prompt is opened, we hit a hurdle: since we aren't actually booted into Windows, drive letters often have a chance to shift. For instance, your primary drive might be `C:` during normal use, but in recovery mode, it could be posing as `D:` or `E:`. We need to verify its identity before we start moving system files around.

1. **Enter 'Diskpart'**: At the Command prompt, type the following command to open the Windows partition manager: `diskpart`
2. **List Your Volumes**: To view all connected drives and partitions, type: `list volume`
3. **Identify The Target**: Scan the list to find the "Main" partition. You are looking for two specific clues:
    * **Size**: It should match the same size of the Windows Installation.
    * **FS (File System)**: Must be formatted as **NTFS**
    * Note the Letter assigned to this volume (e.g `C:`)
4. **Exit to Command Prompt**: Once you've identified the correct letter, type `exit` to return to the standard Command Prompt.

## Step 3: The Utility Manager Swap
Now that we know exactly when Windows is "resting", it's time to perform the swwap. We'll start by backing up the Utility Manager (`Utilman.exe`) and replacing it with a copy of Command Prompt (`cmd.exe`). This will trick Windows into opening a terminal when you click the **Accessibility Icon** on the login screen.

1. **Navigate to the System Directory**: You need to point the Command Prompt to the heart of the OS. Type the drive letter followed by a colon (e.g., `C:`), hit enter, and then run:
`cd windows\system32`
2. **Backup the Original File**: Create a safety net by renaming the original utility so you can restore it later: `copy utilman.exe utilman.exe.bak`
3. **Perform the Swap**: Finally, replace the Utility Manager with a copy of the Command Prompt: `copy cmd.exe utilman.exe`
4. **Confirm**: Type `Yes` and hit **Enter** if the system asks you to overwrite the file.

## Step 4: Reboot & Trigger that "Backdoor"
Now that these two files are swapped, it's time to see what all the hype was about. But first, you need to exit the recovery environment and head back to your standard Windows login screen. 

1. **Restart Your PC**: Close the Command Prompt and restart your computer as you normally would. Be sure to remove your Windows Installation USB, so you don't accidently boot back into the installer. 
2. **Access the Utility Manager**: Once you reach the login screen, look for the **Ease of Access** button (the small icon in the bottom-right corner) and click it.
3. **Open the Command Prompt**: Instead of the usual **accessibility** menu, a Command Prompt window will pop up instead because this utility runs before a user logs in, this Command Prompt has full **administrative** privileges.

## Step 5: Reset Your Password
You're officially "in". Now, all that’s left is to tell Windows to accept a new password of your choosing for your account.

1. **Reset the Account**: In the **Command Prompt**, type the following command. Be sure to replace `<username>` with your current actual account name and `<newpassword>` with your new desired password:

`net user <username> <newpassword>`

2. **Login**: Close the **Command Prompt** and enter the new password you just created into the Windows login box. Congratulations, you've succssfully regained access to your system!

## Step 6: Restore to "Factory" Settings
For obvious security reasons, you shouldn't leave a "backdoor" Command Prompt sitting on your login screen. Leaving an elevated prompt accessible to anyone with physical access to your PC is a significant security risk. Once you've verified that you can log back in, you should restore the original `utilman.exe` file immediately.

1. **Open Command Prompt (Admin)**: Once logged into Windows, right click the Start button and select **Terminal (Admin)** or click the **Start** button, type `cmd`, and select **Run as Administrator**. 
2. **Revert the Previous Changes**: Run the following command to move your backup back into its rightful place: `copy C:\Windows\System32\utilman.exe.bak C:\Windows\System32\utilman.exe`
3. **Confirmation**: Type `Yes` when asked to overwrite the file. 

Your login screen is now back to normal, and your account is secure with your new password.

## Mission Accomplished

Regaining access to your own computer doesn't have to result in a frantic trip to a repair shop or a total system wipe where all your data is lost. By using the Windows Recovery Environment to temporarily swap the Utility Manager for a Command Prompt, you’ve essentially built your own bypass to reset a forgotten password safely.

**A Quick Tip**: Now that you're back in the driver's seat, let's take a moment to set up a safety net so you never have to use this sneaky "backdoor" trick again:
* **Use a Password Manager**: Tools like **Bitwarden** or **1Password** can store complex passwords securely. If you can remember just one "**Master Password**" for these apps, you'll never lose access to your local accounts again.
* **Link Local Account to Microsoft Account**: If you switch your **local** account into a **Microsoft Account**, you can reset your password from any browser or phone via the **offical recovery page**
* **Create a Password Reset Disk**: If you prefer staying "local", Windows has a built in tool to create a recovery USB. Just search for "**Create a password reset disk**" in the **Start** menu while you're logged into Windows.

Stay safe, remember your passwords, and enjoy having your PC back!