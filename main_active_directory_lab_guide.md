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
- Set the computer name (ex: DC01)
- Restart the VM
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
</details>

---

## Installing AD DS Roles

### 1. Open Server Manager
Click **Manage** → **Add Roles and Features**.

### 2. Choose Role-Based Installation
Click Next until you reach Server Roles.

### 3. Install Active Directory Domain Services
<details>
<summary>Check:</summary>
- Active Directory Domain Services
- Allow required features

Click Install.
</details>

---

## 📘 Promoting the Server to Domain Controller

### 1. After Installation
In Server Manager, click the yellow flag → Promote this server to a domain controller.

### 2. Create a New Forest
- Domain name example: home.lab
- NetBIOS name auto-fills (HOME)

### 3. Domain Controller Options
- Leave Forest Functional Level at default
- Keep DNS checked
- Set a DSRM password

### 4. Complete Setup
Click Install.
The server will reboot as a Domain Controller.

---

## 📘 Creating Users & Organizational Units (OUs)

### 1. Open AD Users and Computers (ADUC)
Start → Windows Administrative Tools → Active Directory Users and Computers.

### 2. Create Organizational Units
Right‑click domain → New → Organizational Unit.
Suggested OUs:
- Users
- Admins
- Computers
- Groups

### 3. Create User Accounts
Right‑click Users OU → New → User.
Enter:
- First name
- Last name
- Username (ex: jdoe)

Set an initial password → optionally uncheck “User must change password at next logon.”

### 4. Add Admin Users
Create an account such as helpdesk.admin.
Add them to:
- Domain Admins **or**
- IT Support (recommended, safer)

---

## 📘 Joining a Windows Client to the Domain

### 1. Configure Client Network
Set DNS to the domain controller’s IP:
- Preferred DNS: 192.168.1.10

### 2. Join the Domain
1. Right‑click This PC → Properties
2. Rename this PC (advanced)
3. Change…
4. Select Domain and enter: home.lab
5. Enter domain admin credentials
6. Restart PC

### 3. Log In with Domain User
On login screen:
- Click “Other user”
- Login using: HOME/jdoe

---

## 📘 Group Policies (GPOs)

### 1. Open Group Policy Management
Server → Start → Group Policy Management.

### 2. Create a New GPO
Right‑click domain → Create a GPO.
Examples:
- Password Policy
- Desktop Restrictions
- Disable Control Panel
- Map Network Drives

### 3. Edit GPO
Right‑click GPO → Edit.
Common paths:
- Computer Configuration → Policies → Windows Settings → Security Settings → Account Policies
- User Configuration → Policies → Administrative Templates

### 4. Apply GPO to OUs
Drag GPO onto target OU.

### 5. Force Update on Client
```cmd
gpupdate /force


