# Active Directory Home Lab

![Windows](https://img.shields.io/badge/OS-Windows-blue)
![Windows Server](https://img.shields.io/badge/Server-Windows%20Server%202019%2F2022-blue)
![Lab](https://img.shields.io/badge/Project-Home%20Lab-purple)
![Active Directory](https://img.shields.io/badge/Role-Active%20Directory-3A5BA0)
![Caution](https://img.shields.io/badge/⚠️-Administrative%20Changes-critical)

This guide will walk you through setting up a complete, albeit basic, Active Directory (AD) environment for IT practice project building.

---

<details>
## Goals
<summary>Build a functional AD lab on a home machine using:</summary>

- **Windows Server 2019 (Domain Controller)**
- **Windows 10/11 Client VM**
- **pfSense or NAT networking (optional)**
- **Users, OUs, GPOs, and basic administration tasks**
</details>

---

## Requirements
- Virtualization: VirtualBox, VMware, or Hyper-V
- Windows Server ISO (2019 or 2022)
- Windows 10/11 ISO
- 8–16 GB RAM recommended
- 50–100 GB free disk space

---

## 📘 Setting Up the Domain Controller (Windows Server Install)

### 1. Create a New VM
- Allocate **2–4 vCPUs**
- Assign **4–8 GB RAM**
- Create a **40–60 GB virtual disk**

### 2. Attach the Windows Server ISO
Boot the VM from the ISO.

### 3. Install Windows Server
- Choose **Windows Server 2019/2022 Standard (Desktop Experience)**
- Select **Custom Install**
- Install to the virtual disk

### 4. Initial Configuration
After install completes:
- Create a strong local Administrator password
- Open **Server Manager**
- Set the computer name (ex: DC01)
- Restart the VM

### 5. Configure Network Settings
Set a static IP:
1. Open Network & Internet Settings
2. Change adapter options → Right-click Ethernet → Properties
3. IPv4 Settings:
   - IP: 192.168.1.10 (example)
   - Subnet: 255.255.255.0
   - Gateway: Your router or pfSense box
   - DNS: Use the server’s own IP (192.168.1.10)

---

## 📘 Installing AD DS Role

### 1. Open Server Manager
Click Manage → Add Roles and Features.

### 2. Choose Role-Based Installation
Click Next until you reach Server Roles.

### 3. Install Active Directory Domain Services
Check:
- Active Directory Domain Services
- Allow required features

Click Install.

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
```

---

Let me know what you want to add first, and I’ll fill in the section.

