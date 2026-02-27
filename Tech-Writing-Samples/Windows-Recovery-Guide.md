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

Getting locked out of your computer is a rite of passage for everyone, not just "tech people." It might be an old laptop you found in the back of a closet or a forgotten admin account for the family PC. Whatever the case may be, hitting that "Incorrect Password" error over and over again feels like a dead end when you’ve exhausted every other avenue. But before you give up and delete all your precious files, there’s a classic workaround you might not have heard of. It’s a bit of a "backdoor" trick, but by utilizing the **Windows Recovery Environment** to swap the **Ease of Access utility** for the **Command Prompt**, you effectively bypass the lock screen—allowing you to reset your credentials and get back to work in minutes without losing any important data.

## What You'll Need

* A Windows Installation USB or DVD [(you can download the tool from Microsoft here)](https://www.microsoft.com/en-us/software-download/windows11).
* 10–15 Minutes: This is a quick fix, provided you're comfortable typing a few lines of code into the Command Prompt.

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

1. **Navigate to the System Directory**: First, move the focus of the Command Prompt into the folder where Windows keeps its core files.
2. **Backup the Original File**:
3. **Perform the Swap**:
4. **Confirm**:
