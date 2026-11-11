# AD users, home folders and shared drives

Active Directory exercise (Keuda) in a Windows Server 2022 environment. The domain is `server01.local` and the server is `SERVER01`. A Windows 11 virtual machine is used as the client.

## Screenshot

![Active Directory Users and Computers](images/ad-kayttajat-ja-ou.png)

*Active Directory Users and Computers: under `server01.local` is the SERVER01 organizational unit with the sub-OUs Hallinto, Helpdesk and Opetus. The Helpdesk OU contains the Ylläpito group (Security Group - Global) and the users Helena Kukkonen and Lari Venho.*

## Organizational units and groups

| OU | Group |
|---|---|
| Helpdesk | Ylläpito (administration) |
| Hallinto | Hallinto (management) |
| Opetus | Opiskelijat (students) |

## Users

| OU | Name | Groups | Job title | Logon script |
|---|---|---|---|---|
| Hallinto | Maija Mutikainen | Hallinto | Johdon assistentti | hallinto.bat |
| Hallinto | Risto Ratilainen | Hallinto | Johtaja | hallinto.bat |
| Hallinto | Simo Siili | Hallinto | Koulutuspäällikkö | hallinto.bat |
| Opetus | Jukka Mäntylä | Opiskelijat | opiskelija | oppilaat.bat |
| Opetus | Antti Ajattelija | Opiskelijat | opiskelija | oppilaat.bat |
| Helpdesk | Lari Venho | Ylläpito, Domain Admins, Enterprise Admins | ICT manager | PC.bat |
| Helpdesk | Helena Kukkonen | Ylläpito, Domain Admins | IT-tukihenkilö | PC.bat |

On each user's Profile tab:
- **Logon script:** the .bat file from the table above
- **Home folder:** Connect `K:` to `\\SERVER01\homes\%username%`

## Shared folders (C:\)

| Folder | Share | Drive | Permissions |
|---|---|---|---|
| Homes | `\\SERVER01\homes` | K: (home folder) | The user themselves |
| Opiskelijat | `\\SERVER01\opiskelijat` | O: | Opiskelijat: Modify, Hallinto: Read, Ylläpito: Full control |
| Hallinto | `\\SERVER01\hallinto` | M: | Hallinto: Full control, Ylläpito: Full control |
| Util | `\\SERVER01\util` | Z: | Ylläpito: Full control |

## Logon scripts

The scripts were written in Notepad and saved in the server's NETLOGON folder (`C:\Windows\SYSVOL\sysvol\server01.local\scripts`, or `\\SERVER01\netlogon` from the network). Copies are in the [scripts](scripts/) folder.

| Script | Users | Mapped drives |
|---|---|---|
| [PC.bat](scripts/PC.bat) | Ylläpito | O:, M:, Z: |
| [hallinto.bat](scripts/hallinto.bat) | Hallinto | O:, M: |
| [oppilaat.bat](scripts/oppilaat.bat) | Opiskelijat | O: |

Example, `PC.bat`:

```bat
@echo off
net use o: \\SERVER01\opiskelijat
net use m: \\SERVER01\hallinto
net use z: \\SERVER01\util
```

## Step-by-step procedure

All steps are done on `SERVER01` as a domain administrator.

### 1. Create the organizational units and groups

1. Open **Server Manager > Tools > Active Directory Users and Computers**.
2. Right-click the domain `server01.local` and select **New > Organizational Unit**. Create the top-level OU `SERVER01`.
3. Under `SERVER01`, create three OUs: `Helpdesk`, `Hallinto` and `Opetus`.
4. In each OU, right-click and select **New > Group**. Use group scope **Global** and group type **Security**:
   - `Helpdesk`: `Ylläpito`
   - `Hallinto`: `Hallinto`
   - `Opetus`: `Opiskelijat`

### 2. Create the users

1. Right-click the correct OU and select **New > User**. Enter the name and a logon name, then set a password.
2. Open the user's **Properties**:
   - **Organization** tab: enter the **Job title** from the user table.
   - **Member Of** tab: add the groups from the user table. Lari Venho is a member of `Ylläpito`, `Domain Admins` and `Enterprise Admins`. Helena Kukkonen is a member of `Ylläpito` and `Domain Admins`.
3. Repeat for all seven users.

### 3. Create the Homes folder (K: drive)

1. Create the folder `C:\Homes`.
2. Right-click it, select **Properties > Sharing > Advanced Sharing**, tick **Share this folder** and name the share `homes`. Give the share permissions needed for users to create and modify their own folders (for example Everyone: Full control at share level, with access limited by NTFS permissions).
3. In each user's **Properties > Profile** tab, under **Home folder**, select **Connect**, choose drive `K:` and enter `\\SERVER01\homes\%username%`. Active Directory creates the personal folder automatically when the setting is applied.

### 4. Create the shared folders (Opiskelijat, Hallinto, Util)

1. Create `C:\Opiskelijat`, `C:\Hallinto` and `C:\Util`.
2. Share each folder with **Advanced Sharing**, using the share names `opiskelijat`, `hallinto` and `util`.
3. Set the permissions in **Properties > Security** (disable inheritance and remove the default `Users` entries first):

| Folder | Group | Permission |
|---|---|---|
| Opiskelijat | Opiskelijat | Modify |
| Opiskelijat | Hallinto | Read |
| Opiskelijat | Ylläpito | Full control |
| Hallinto | Hallinto | Full control |
| Hallinto | Ylläpito | Full control |
| Util | Ylläpito | Full control |

### 5. Write the logon scripts

1. Open **Notepad** and type the commands for each script (see the [scripts](scripts/) folder).
2. Save with **Save as type: All files** and the file name `PC.bat`, `hallinto.bat` or `oppilaat.bat`, so that Notepad does not add `.txt`.
3. Save the files in the NETLOGON scripts folder: `C:\Windows\SYSVOL\sysvol\server01.local\scripts` (reachable from any computer in the domain as `\\SERVER01\netlogon`).

The scripts are cumulative: `hallinto.bat` also maps the students' `O:` drive, and `PC.bat` also maps both of the previous drives.

### 6. Assign the logon scripts

In each user's **Properties > Profile** tab, enter the script name in the **Logon script** field, for example `pc.bat`. As an alternative, the script can be assigned to a whole OU with a Group Policy (**User Configuration > Policies > Windows Settings > Scripts > Logon**).

### 7. Test

1. Log in to the Windows 11 client with a user from each group.
2. Check that the correct drives are mapped (`net use` or File Explorer): `K:` for everyone, `O:` for students, `M:` and `O:` for Hallinto, and `K:`, `O:`, `M:` and `Z:` for Ylläpito.
3. Confirm that the permissions work, for example that a student can modify files in `O:` but cannot open `M:`.

### 8. Screenshot

Take a screenshot of the users and organizational units in **Active Directory Users and Computers** (see the top of this page) and submit it for assessment.
