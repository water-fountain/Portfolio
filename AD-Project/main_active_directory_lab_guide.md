# Active Directory Home Lab

![Windows](https://img.shields.io/badge/OS-Windows-blue)
![Windows Server](https://img.shields.io/badge/Server-Windows%20Server%202019%2F2022-blue)
![Lab](https://img.shields.io/badge/Project-Home%20Lab-purple)
![Active Directory](https://img.shields.io/badge/Role-Active%20Directory-3A5BA0)
![Caution](https://img.shields.io/badge/⚠️-Administrative%20Changes-critical)

This is a hands-on Active Directory Home Lab designed to simulate a real life enterprise infrastructure.
This project/guide includes a domain controller, Organizational Structures, Users, Security Groups, Mapped Drives, GPO's, and so much more - mirroring real life modern IT environments.

The goal of this lab is to:
- Build practical skills in **Windows Server 2019**, **AD DS**, **GPOs**, & **file services**.
- Create portfolio-ready IT examples.
- Understand real-world administration workflows.

## Requirements
To build this Active Directory Home Lab, you will need:

### Virtualization Platform
Choose one of the following:
   - **VirtualBox** (free) -> https://www.virtualbox.org/wiki/Downloads
   - **VMware Workstation/Player**
   - **Hyper-V**

### Operating System ISOs
Download the installer images:
   - **Windows Server (2019 or 2022) ISO** -> https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2019
   - **Windows 10/11 ISO** -> https://www.microsoft.com/en-us/software-download/windows11

### Hardware Recommendations
This are recommended to have:
   - **8–16 GB RAM recommended**
   - **50–100 GB free disk space**
   - **Quad-core CPU recommended**

### Networking Requirements
   - Internal network or NAT network (VBox/VMware/Hyper-V)

## Setting Up the Domain Controller (Windows Server 2019 / 2022 Install)

### 1. Create a New VM
<details>
<summary>When creating the VM:</summary>

- CPU: **2-4 vCPUs**
- RAM: **4-8 GB**
- Disk: **40-60 GB**
- Network Adapter: **Internal Network / Host-Only / LabNet**
</details>

### 2. Attach the Windows Server ISO
<details>
<summary>While attaching:</summary>

- Mount the **Windows Server 2019/2022** ISO
- Start the VM
</details>

### 3. Install Windows Server
<details>
<summary>While Installing:</summary>

- Choose **Windows Server 2019/2022 Standard (Desktop Experience)**
- Select **Custom Install**
- Install to the newly created virtual disk
</details>

### 4. Initial Configuration
<details>
<summary>After configuration completes:</summary>

- Create/Set a **strong** *local Administrator* password (i.e **OldPassword123!**)
- Open **Server Manager**
- Set the computer/system name (ex: SRV-DC01)
- Restart the VM

![alt text](<images/Domain Name Creation.png>)

</details>

### 5. Configure Network Settings (Static Networking)
<details>
<summary>Setting up a static IP:</summary>

1. Open **Network & Internet Settings**
2. Change **adapter options** → Right-click **Ethernet** → **Properties**
3. IPv4 Settings: 
   - IP: 192.168.10.1
   - Subnet: 255.255.255.0
   - Gateway: BLANK
   - Preferred DNS: 192.168.10.1
   
![alt text](<images/Static-IP Settings.png>)

</details>

## Installing AD DS Roles
After your server is renamed and assigned a static IP, you can begin installing the roles required for Active Directory Domain Services (AD DS)

### 1. Open Server Manager
Server Manager usually opens automatically on login, but you can also launch it from the start menu

### 2. Add Roles & Features
Click **Manage** → **Add Roles and Features**.

### 3. Choose Installation Type 
<details>
<summary>Steps:</summary>

   - Select **Role-based or feature-based installation**

![alt text](<images/Role-based Selection.png>)
   
   - Click **Next**

</details>

### 4. Select Your Server
<details>
<summary>Steps:</summary>
   - Choose your server from the list (ex. SRV-DC01.lab.local)

   ![alt text](<images/Server Pool - Server.png>)

   - Click **Next**

</details>

### 5. Select Server Roles & Features
<details>
<summary>Server Roles & Features:</summary> 

   - **Active Directory Domain Services**
   - **DNS Server**
   - **DHCP Server** *(optional but recommended for labs)*
   - **File and Storage Services**
   - **Remote Server Administration Tools**
   - **Windows Defender Antivirus**
   - **Windows PowerShell**
   - **Windows Server Backup** *(optional)*

If prompted, click **Add features** for any dependency warnings

Click **Next**.
</details>

### 6. Confirm & Install
   - Review the summary
   - Click **Install**
   - Allow installation to complete

## Promoting the Server to Domain Controller

### 1. Launch Promotion Wizard
In Server Manager after installing AD DS, click the yellow notification flag, then select:
   - Promote this server to a domain controller.

### 2. Create a New Forest
<details>
<summary>Choose:</summary>

- **Add a new forest**
- Enter a Domain Name: (ex: **lab.local**)
- NetBIOS name will auto-fill(ex: **LAB**)

Click **Next**.

</details>

### 3. Domain Controller Options
Configure the following:
<details>
<summary>Checklist:</summary>

- **Forest Functional Level**: **default**
- **Domain Functional Level**: **default**
- **Domain Controller Capabilities:**
   - DNS Server **checked**
   - Global Catalog **checked**
   - RODC (Read-Only Domain Controller) **unchecked**
- Set a **DSRM** (Directory Services Restore Mode) password

Click **Next.**

</details>

### 4. DNS & Additional Options
<details>
<summary>Notes:</summary>

- If a **DNS delegation warning** appears -> this is normal -> Click next
- Accept all default paths for **Databae, SYSVOL, & Log files**

Continue until the **Review Options** page 

</details>

### 5. Complete Installation
<details>
<summary>Final Steps:</summary>

- Review **all** settings 
- Let the **prerequisite check** complete 
- Click **Install**
- The server will automatically reboot
- The server will now reboot as a **Domain Controller** in a brand new forest

</details>

## Creating Users, Security Groups, & Organizational Units (OUs)
This section covers the core structure of the Active Directory environment. You & I will be able to create organizational units, security groups, and user accounts that reflect a real-world enterprise environment.

### 1. Open AD Users and Computers (ADUC)
<details>
<summary>Steps:</summary>

- Click **Start**
- Search for **Windows Administrative Tools**
- Click **Active Directory Users and Computers**

![alt text](<images/ADUC Folder.png>)

</details>

### 2. Create Organizational Units
<details>
<summary>Suggested OUs & Layout:</summary>

- CorpUsers
   - Sales
   - HR
   - IT
   - HelpDesk
- Workstations
   - Sales
   - HR
   - IT
   - HelpDesk
- Groups
- Admins 
- Service Accounts 

![alt text](<images/DC Folders.png>)

</details>

<details>
<summary>How to Create an OU:</summary>

- Open **Active Directory Users & Computers** again
- Right click your domain (ex. **lab.local**)
- Select **New** -> **Organizational Unit**

![alt text](<images/New OU Path.png>)

- Enter the **OU** name (ex. **Sales**)

![alt text](<images/New OU Creation.png>)

- Click **OK**

</details>

### 3. Create Security Groups
Security groups define permissions for shared folders, mapped drives, & GPO targeting.
<details>
<summary> Recommended Global Security Groups:</summary> 

- **SalesUsers** 
- **HRUsers**
- **ITUsers**
- **HelpDesk** (Limited Admin) 
- **IT_Admins** (Administrative)

</details>

<details>
<summary>To create a security group:</summary>

   - Right-click the **Groups** OU
   - Select **New** -> **Group**
   - Configure:
      - Group Name: **SalesUsers**
      - Group Scope: **Global**
      - Group Type: **Security**
   - Click **OK**

Repeat for each department wanted

</details>

### 4. Create User Accounts
Create real user accounts inside the corresponding departmental OU.
<details>
<summary>Steps:</summary>

- In **Active Directory Users & Computers**, navigate to the your desired OU:
   - CorpUsers -> Sales (or HR, IT, etc)
- Right-click the **OU** -> **New** -> **User**

![alt text](images/New-OU-User.png)
- Fill in: 
   - First name (ex. **Alexander**)
   - Last name (ex. **Smith**)
   - User logon Name (ex: **salesrep01**)

![alt text](images/New-Obj-User-Creation.png)

- Set an **initial password** → **optionally** uncheck “User must change password at next logon.”

![alt text](images/User-Password-Creation.png)

- Click **Next**, then **Finish**

</details>

### 5. Add Users to Security Groups 
<details>
<summary>After creating a user:</summary>

- Right-click the user -> **Properties**
- Go to the **Member of** tab
- Click **Add**
- Enter the **correct department group** (ex. **SalesUsers, HRUsers, ITUsers**)
- Click **OK**

![alt text](images/User-Member-of-Properties.png)

Now the user will inherit:
   - NTFS folder permissions
   - Share Access
   - GPO targeting (mapped drives, restrictions, etc)

</details>


### 6. Creating Administrative Accounts
Create dedicated admin identities with least privilege.
Never use built-in Administrator account for daily work.
<details>
<summary>Steps:</summary>

- Open **Active Directory Users and Computers** (ADUC) 

![alt text](images/Opening-ADUC.png)

- Navigate to the **Admins** -> **AdminUsers OU** (create if not done so already)

![alt text](images/Admin-Dropdown.png)

- Right-click the **OU** -> **New** -> **User**

![alt text](images/New-OU-User2.png)

- Fill in the account information:
   - First Name: (ex. Janet)
   - Last Name: (ex. Finnel)
   - User Logon Name: (ex. jdoe.admin)

![alt text](images/New-Obj-User-Creation2.png)

- Click **Next**
- Set a **strong password**:
   - Enable options as needed

- Click **Next**, then **finish** to create the account
- Add the new account to the **IT_Admins security group**:
   - **Right-click** the user -> **Properties** -> **Member of** tab -> **Add** -> Enter **IT_Admins** -> **Check Names** -> **Ok**

![alt text](images/Adding-User-SG.png)

</details>

## Creating Departmental Shared Folders
Provides shared access of files for departments with proper permissions.
<details>
<summary>Steps:</summary>

- Log into your server
- Click the search bar, open file explorer & navigate to your desired location for your shared folders (e.g **C:\DeptShares**)
- Create folders for each department you'd like:
   - **Sales**
   - **HelpDesk**
   - **IT**

![alt text](images/Creation-Dpt-Folders.png)

- Right-click each folder -> Click **properties** -> **Sharing tab** -> **Advanced Sharing**

![alt text](images/Adv-Sharing-Location.png)

- Now check **share this folder**, set a **share name**, then click **permissions**.
- Add the corresponding **security group** for each folder & assign **permissions**:
   - Sales -> **SalesUsers** -> **Modify**
   - HelpDesk -> **HelpDesk** -> **Modify**
   - IT_Admins -> **IT_Admins** -> **Full Control**

![alt text](images/Perm-Modifications-Folders.png)

- Click **apply**, then **ok**
- Switch to **security tab** to make sure that the **NTFS permissions** match the **share permissions**

![alt text](images/Sec-Perms-Properties.png)

- Test access by using another **VM** as a user from each **group**

</details>

## Creating Group Policies (GPOs)
The purpose of GPO's is to enforce **policies** & automate various **configurations** for users & their computers
<details>
<summary>Steps:</summary>


- Open **Group Policy Management Console** (GPMC):
   - **Start** -> **Administrative Tools** -> **Group Policy Management**

![alt text](images/GPM-Dropdown.png)

- Right click your domain (**lab.local**) -> **Create a GPO in this domain, & link it here..**

![alt text](images/GPO-Domain-Creation.png)

- Give your new **GPO** a **descriptive name** (ex. **Password Policy GPO**)

![alt text](images/GPO-Name-Creation.png)

- Right-click the **GPO** -> edit to open the **Group Policy Management Editor**

![alt text](images/GPME.png)

- Configure policies based on a specific purpose, below are some examples:

---

   - **Password Policy:** **Computer Configuration** -> **Policies** -> **Windows Settings** -> **Security Settings** -> **Account Policies** -> **Password Policy**
      - Policies enabled in this instance: **Password must meet complexity requirements** & **Minimum password length**

![alt text](images/PP-Settings.png)

![alt text](images/ALP-Settings.png)

---

   - **Desktop Restrictions:** **User Configuration** -> **Policies** -> **Adminstrative Templates** -> **Desktop**
      - Policies enabled in this instance: **Hide & Disable all items on the desktop, Remove My Documents icon on Desktop, Hide Network Locations, Remove Properties from the Computer Icon, & Remove recycle bin icon from desktop**

![alt text](images/Desktop-Settings.png)

![alt text](images/Desktop-Settings2.png)

---

   - **Control Panel Restrictions:** **User Config** -> **Admin Templates** -> **Control Panel** -> **Prohibit access to Control Panel**

![alt text](images/CP-Settings.png)

---

   - **Drive Mapping:**
      
   - Create Department folders
      - Inside `C:\DeptShares`, create:
         - **Sales**
         - **HR**
         - **IT**
         - **HelpDesk**

![alt text](images/HR-Folder-Dropdown.png)

---

   - Configure **NTFS Permissions**
   Each department folder gets modify rights for respective department group & full control for administrators
      - Ex. for Sales:
         - Right click **Sales** -> **Properties** -> **Security** -> **Advanced**
         - Click **Disable Inheritance** -> Convert **inherited permissions**
         
         ![alt text](images/Sales-NTFS-Perms.png)

         - Remove all unnecessary principals to your liking 
         - Add the following:
            - Domain Admins -> **Full Control**
            - SalesUsers -> **Modify**
         - WARNING: 
            - Don't use individual user accounts
            - Don't give full control to non-admins
   - Share the folder
      - Right click **sales folder** -> **Properties** -> **Sharing** -> **Advanced Sharing**
         - Check **Share this folder**
         - Share name: **Sales**

         ![alt text](images/Share-Folder-Dropdown.png)

         - Click **Permissions** -> Remove everyone 
         - Add:
            - SalesUsers -> **Read/Write**
            - Domain Admins -> **Full Control**

         ![alt text](images/SalesUsers-Perms.png)
         
         - Close editor when finished

---

   - Enable **Access-Based Enumeration (ABE)**
   This hides folders users do not have NTFS permissions to.
      - Open Server Manager
      - Go to:
         - **File & Storage Services -> Shares**
      - **Right-click your share -> Properties**
      - Under settings, check:
         - **Enable access-based enumeration**

         ![alt text](images/Enable_ABE.png)

      Now HR users cannot even see the Sales folder, & vice versa

---

   - Create Mapped Drive GPO
   Path: Group Policy Management -> CorpUsers -> Department OU
      - Right-click the OU -> Create a GPO in this domain & link it here...
   Name ex. Sales - Mapped Drive

   Edit the GPO:
      - User Config -> Pref -> Windows Settings -> Drive Maps 
      - Right-click -> New -> Mapped Drive 
   
---

   - Configure the Drive Mapping 
      - Action: **Create**
      - Location:
      - Label as: Sales **Share**
      - Drive Letter: **S:**
      - Reconnect: **Y**

      ![alt text](images/Create-Drive-Mapping.png)

   - Common Tab -> Item-Level Targeting
      - Check **Item-level targeting**
      - Click **Targeting...**
      - **New Item** -> **Sec Group**
      - Group: **SalesUsers**
      - Match: **User in group**

      ![alt text](images/Targeting-Editor-Dropdown.png)

---

   - Security Filtering 
   For each department GPO:
      - Keep:
         - **Authenticated Users**
         - **SalesUser** (or HRUsers, ITUsers, etc)
      - Do not Keep / Add:
         - Computers
         - Domain Admins
         - IT Admins
         - Everyone 

---

   - Apply GPO on the Client Machine
   On the Client's workstation:
      - `gpupdate /force`
   Then log out & back in
   Mapped drives only appear at user logon

---

   - Test the Configuration
   Test UNC Path:
      - `\\SRV-DC01\Sales` on search bar
      or 
      - `start \\SRV-DC01\HR` on CMD
      If the folder appears:
         - UNC path is working
         - **Share** + **NTFS** is correct
      - Mapped drive should now work
   
   - Check applied GPOs:
      - `gpresult /r`
      Under User Settings, you should encounter:
         - Sales - Mapped Drives
      - Check Drive Mapping:
         - Open **This PC** & **verify**

</details>

## Troubleshooting Guide
Below may be some common issues you may encounter in a basic AD Home Lab & how to resolve them.

### Mapped Drives Not Appearing

<details>
<summary>Symptoms</summary>

   - Drive letter does not show in *This PC*
   - `gpresult /r` does not list the GPO 
   - **UNC path**works but drive mapping does not

</details>

<details>
<summary>Fixes</summary>

- Ensure the following doesn't conflict with your mapped drives
      - **Control Panel Restrictions**
      - **Desktop Restrictions**
      - Any **GPO**
   - Verify Security Filtering includes:
      - **Authenticated Users**
      - Correct department group (**HRUsers, SalesUsers**, etc)
   - Ensure correct **Item-Level Targeting**:
      - **User is in group** (not "**primary group**")
   - Always remember to run: `gpupdate /force`
      - log out, & log back in again

</details>

### The network name cannot be found
<details>
<summary>Symptoms</summary>

- `\\SRV-DC01\Share` fails
- `start \\Server\Share` returns error

</details>

<details>
<summary>Fixes</summary>

- Test hostname resolution:
   - `ping SRV-DC01`
   - `nslookup SRV-DC01`

- If hostname fails but IP works:
   - Check DNS client settings (must point to DC)
   - Ensure DC's DNS service is running

- Test UNC directly:
   - start `\\192.168.10.10\HR`

</details>

### GPO Not Applying
<details>
<summary>Fixes</summary>

- Verify the **GPO** is linked to the correct **OU**
- Ensure the **user/computer** is inside the **OU**
- Check inheritance:
   - `gpresult /h report.html`
- Remove extra filters (like computers, admins, etc)

</details>

## Network Topology
<details>
<summary>Network Diagram</summary>

![alt text](images/Network-Diagram.png)

</details>

### Legend
<details>
<summary>What means what?</summary>

- **SRV-DC01** — Windows Server 2019 Domain Controller  
  - Hosts: AD DS, DNS, DHCP (optional), File Shares, GPOs  
  - IP: **192.168.10.1**

- **HRWS01** — HR department workstation  
  - IP: **192.168.10.2**

- **ITWS01** — IT department workstation  
  - IP: **192.168.10.3**

- **SLSWS01** — Sales department workstation  
  - IP: **192.168.10.4**

- **Internal Network**  
  - Subnet: **192.168.10.0/24**

- **UNC Path Examples**
  - `\\SRV-DC01\HR`
  - `\\SRV-DC01\IT`
  - `\\SRV-DC01\Sales`

- **Drive Mapping**
  - H: → HR Share  
  - I: → IT Share  
  - S: → Sales Share  

</details>

## What I Learned 
Working through this whole lab, it taught me several core IT concepts that directly apply to real life enterprise environments:

<details>
<summary>Active Directory Fundamentals</summary>

- How domains, OUs, users, computers, and security groups function together  
- Why organizations use **role-based access control (RBAC)** rather than per-user permissions  
- The importance of separating **admin** and **standard** accounts  

</details>

<details>
<summary>Group Policy (GPO)</summary>

- How to create, link, and scope GPOs to specific OUs  
- The difference between:
  - **Policies** (enforce configurations)
  - **Preferences** (apply settings like mapped drives)  
- How **Security Filtering** + **Item-Level Targeting** determine who receives a GPO  

</details>

<details>
<summary>File Sharing & Permissions</summary>

- How to configure **NTFS permissions** vs. **Share permissions**  
- Why Access-Based Enumeration hides folders users cannot access  
- How UNC paths work: `\\SRV-DC01\ShareName`  

</details>

<details>
<summary>Networking & DNS</summary>

- Setting static IPs for domain environments  
- Why Windows clients *must* use the Domain Controller as DNS  
- Troubleshooting share access with:
  - `ping`
  - `nslookup`
  - `net view`
  - `start \\Server\Share`  

</details>

<details>
<summary>Troubleshooting Skills</summary>

- Fixing workstation trust issues  
- Rejoining computers to the domain  
- Diagnosing GPO problems using:
  - `gpupdate /force`
  - `gpresult /r`
  - Event Viewer  

Overall, I learned how Windows enterprise environments are structured, how permissions flow, and how to diagnose issues across layers like a real Help Desk or SysAdmin technician could.

</details>


*Created by [B. Fontaine]*

