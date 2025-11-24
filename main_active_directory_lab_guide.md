# Active Directory Home Lab

![Windows](https://img.shields.io/badge/OS-Windows-blue)
![Windows Server](https://img.shields.io/badge/Server-Windows%20Server%202019%2F2022-blue)
![Lab](https://img.shields.io/badge/Project-Home%20Lab-purple)
![Active Directory](https://img.shields.io/badge/Role-Active%20Directory-3A5BA0)
![Caution](https://img.shields.io/badge/⚠️-Administrative%20Changes-critical)

This guide will walk you through setting up a complete, albeit basic, Active Directory (AD) environment for IT practice project building.

---

## Goal
<details>
<summary>Build a functional AD lab on a home machine using:</summary>

- **Windows Server 2019 (Domain Controller)**
- **Windows 10/11 Client VM**
- **pfSense or NAT networking (optional)**
- **Users, OUs, GPOs, and basic administration tasks**
</details>

---

## Requirements
- Virtualization: VirtualBox, VMware, or Hyper-V https://www.virtualbox.org/wiki/Downloads
- Windows Server ISO (2019 or 2022) https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2019
- Windows 10/11 ISO https://www.microsoft.com/en-us/software-download/windows11
- 8–16 GB RAM recommended
- 50–100 GB free disk space

---

## Setting Up the Domain Controller (Windows Server 2019 / 2022 Install)

### 1. Create a New VM
<details>
<summary>When creating the VM:</summary>

- Allocate **2–4 vCPUs**
- Assign **4–8 GB RAM**
- Create a **40–60 GB virtual disk**
</details>

### 2. Attach the Windows Server ISO

### 3. Install Windows Server
<details>
<summary>While Installing:</summary>

- Choose **Windows Server 2019/2022 Standard (Desktop Experience)**
- Select **Custom Install**
- Install to the virtual disk
</details>

### 4. Initial Configuration
<details>
<summary>After install completes:</summary>

- Create a **strong** local Administrator password (i.e **OldPassword123!**)
- Open **Server Manager**
- Set the computer name (ex: SRV-DC01)
- Restart the VM

![alt text](image-1.png)
</details>

### 5. Configure Network Settings
<details>
<summary>Setting up a static IP:</summary>

1. Open Network & Internet Settings
2. Change **adapter options** → Right-click **Ethernet** → **Properties**
3. IPv4 Settings: 
   - IP: 192.168.10.10 (example)
   - Subnet: 255.255.255.0
   - Gateway: 192.168.10.1 (example)
   - Preferred DNS: 127.0.0.1 (loopback) 
   
![picture](image.png)
</details>

---

## Installing AD DS Roles

### 1. Open Server Manager
Click **Manage** → **Add Roles and Features**.

### 2. Choose Role-Based Installation
Click Next until you reach **Server Roles**.

### 3. Install Active Directory Domain Services & Features
<details>
<summary>Checklist:</summary>

- Active Directory Domain Services
- DHCP Server
- DNS Server
- File & Storage Services 
- Remote Server Administrator Tools 
- Windows Defender Anitvirus 
- Windows Powershell 
- Window Server Backup

Click Install. (You can mix & match what you would like to add)
</details>

---

## Promoting the Server to Domain Controller

### 1. After Installation
In Server Manager, click the yellow notification flag → Promote this server to a domain controller.

### 2. Create a New Forest
<details>
<summary>When Creating:</summary>

- Choose **Add a new forest**
- Enter your Domain name. Example: (**lab.local**)
- NetBIOS name auto-fills the name (e.g **LAB**)

Click **Next.**

</details>

### 3. Domain Controller Options
<details>
<summary>Checklist:</summary>

- Leave **Forest Functional Level** at **default**
- Leave **Domain Functional Level** at **default**
- Ensure **DNS server** is **checked**
- **Global Catalog** should be **checked**
- Leave **RODC** (Read-Only Domain Controller) **unchecked**
- Set a **DSRM** (Directory Services Restore Mode) password

Click **Next.**

</details>

### 4. DNS & Additional Options
- A DNS delegation **warning** may appear - this is normal, you may **skip**
- Click **next** through additional options and paths pages

### 5. Complete Setup
- Review **all** settings 
- Let the prerequisite check complete 
- Click **Install**

The server will reboot as a **Domain Controller**.

---

## Creating Users, Security Groups, & Organizational Units (OUs)

### 1. Open AD Users and Computers (ADUC)
<details>
<summary>Steps:</summary>

- Start by clicking the search bar
- Type **Windows Administrative Tools**, and click it
- Click **Active Directory Users and Computers**

![alt text](image-21.png)

</details>

### 2. Create Security Groups
<details>
<summary>Recommended Security Groups:</summary> 

Create desired groups to organize **permissions and role-based access** in your domain 

- **SalesUsers** - **Standard** Users in Sales dapartment 
- **HelpDesk** - Help desk staff with **limited** admin privileges to resolve issues
- **IT_Admins** - **Full** administrative rights for IT staff

</details>

<details>
<summary>How to Create a Security Group</summary>

- Open **Active Directory Users and Computers**
- Navigate to the **OU** where you would like to store your groups (e.g **CorpUsers** -> **IT** or another dedicated Group OU)

![alt text](image-19.png)

- Right click the **OU** -> **New** -> **Group**
- Configure the following:
   - Group Name: (ex. **IT_Admins**) 
   - Group Scope: **Global**
   - Group Type: **Security**

![alt text](image-20.png)

- Click **Ok** to create the group.

You can now add users to these groups to create accounts, in this instance, for the IT department

</details>

### 3. Create Organizational Units
<details>
<summary>Suggested OUs:</summary>

- Users
- Admins
- Computers
- Groups
- CorpUsers
- Workstations
- Service Accounts

</details>

<details>
<summary>How to Create an OU</summary>

- Open **Active Directory Users & Computers**
- Right click your domain (ex. **lab.local**)
- Select **New** -> **Organizational Unit**

![alt text](image-17.png)

- Enter the **OU** name (ex. **Sales**)

![alt text](image-18.png)

- Click **OK**

Repeat for each department you would want to organize

</details>

### 4. Create User Accounts
Create users inside the correct department OU for clear and more efficient management
<details>
<summary>Creating a User</summary>

- In **Active Directory Users & Computers**, navigate to the your desired OU. (Ex. lab.local -> **Sales**)
- Right-click the **OU** -> **New** -> **User**

![alt text](image-14.png)

- Fill in: 
   - First name (ex. Alexander)
   - Last name (ex. Smith)
   - User logon Name (ex: **salesrep01**)

![alt text](image-15.png)

- Set an **initial password** → **optionally** uncheck “User must change password at next logon.”

![alt text](image-16.png)

- Click **Next**, then **Finish**

</details>

### 5. Adding Users to Security Groups 
After creating a user, add them to the appropriate group by:
<details>
<summary>Steps:</summary>

- Right-click the user -> Properties

![alt text](image-12.png)

- Go to the **Member of** tab
- Click **Add**
- Enter the **group name** (ex. **Sales_Users, HelpDesk_Techs, IT_Admins**)
- Click **OK**

![alt text](image-13.png)

Users now will inherit permissions based on the groups assigned to them.

</details>


### 6. Creating Administrative Accounts
Create dedicated administrative accounts seperate from standard users for security and proper role management. 
<details>
<summary>Steps:</summary>

- Open **Active Directory Users and Computers** (ADUC) 

![alt text](image-7.png)

- Navigate to the **Admins** -> **AdminUsers OU** (create if not done so already)

![alt text](image-6.png)

- Right-click the **OU** -> **New** -> **User**

![alt text](image-8.png)

- Fill in the account information:
   - First Name: (ex. Janet)
   - Last Name: (ex. Finnel)
   - User Logon Name: (ex. jdoe.admin)

![alt text](image-9.png)

- Click **Next**
- Set a **strong password**:
   - Enable options as needed

![alt text](image-10.png)

- Click **Next**, then **finish** to create the account
- Add the new account to the **IT_Admins security group**:
   - **Right-click** the user -> **Properties** -> **Member of** tab -> **Add** -> Enter **IT_Admins** -> **Check Names** -> **Ok**

![alt text](image-11.png)

</details>

---

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

![alt text](image-3.png)

- Right-click each folder -> Click **properties** -> **Sharing tab** -> **Advanced Sharing**

![alt text](image-2.png)

- Now check **share this folder**, set a **share name**, then click **permissions**.
- Add the corresponding **security group** for each folder & assign **permissions**:
   - Sales -> **SalesUsers** -> **Modify**
   - HelpDesk -> **HelpDesk** -> **Modify**
   - IT_Admins -> **IT_Admins** -> **Full Control**

![alt text](image-4.png)

- Click **apply**, then **ok**
- Switch to **security tab** to make sure that the **NTFS permissions** match the **share permissions**

![alt text](image-5.png)

- Test access by using another **VM** as a user from each **group**

</details>

---

## Creating Group Policies (GPOs)
The purpose of GPO's is to enforce **policies** & automate various **configurations** for users & their computers
<details>
<summary>Steps:</summary>


- Open **Group Policy Management Console** (GPMC):
   - **Start** -> **Administrative Tools** -> **Group Policy Management**

![alt text](image-22.png)

- Right click your domain (**lab.local**) -> **Create a GPO in this domain, & link it here..**

![alt text](image-23.png)

- Give your new **GPO** a **descriptive name** (ex. **Password Policy GPO**)

![alt text](image-24.png)

- Right-click the **GPO** -> edit to open the **Group Policy Management Editor**

![alt text](image-25.png)

- Configure policies based on a specific purpose, below are some examples:
   - **Password Policy:** **Computer Configuration** -> **Policies** -> **Windows Settings** -> **Security Settings** -> **Account Policies** -> **Password Policy**
      - Policies enabled in this instance: **Password must meet complexity requirements** & **Minimum password length**

![alt text](image-28.png)

![alt text](image-26.png)


   - **Desktop Restrictions:** **User Configuration** -> **Policies** -> **Adminstrative Templates** -> **Desktop**
      - Policies enabled in this instance: **Hide & Disable all items on the desktop, Remove My Documents icon on Desktop, Hide Network Locations, Remove Properties from the Computer Icon, & Remove recycle bin icon from desktop**

![alt text](image-27.png)

   - **Task Manager Restrictions:** **User Config** -> **Admin Templates** -> **Control Panel** -> Prohibit access to Control Panel

![alt text](image-29.png)

   - 