# Windows Server

Windows Server 2022, Active Directory, Group Policy and IIS exercises, including the Windows 11 client side of the domain.

## Projects

- [AD users, home folders and shared drives](ad-users-and-shared-drives/README.md): organizational units, groups, users, shared folders and logon scripts.
- [Windows 11 workstation and domain join](windows-11-domain-join/README.md): installing a Windows 11 client, joining it to the domain and testing the mapped drives.
- [Domain password and account lockout policy](password-and-lockout-policy/README.md): password history, age, length and complexity, and account lockout settings in the Default Domain Policy.
- [Desktop wallpaper Group Policy](desktop-wallpaper-gpo/README.md): a GPO that sets a common wallpaper from a network share, tested on a domain client.
- [Installing Firefox on clients with Group Policy](firefox-software-deployment-gpo/README.md): assigning an MSI package to the computers in a dedicated OU and testing it on a domain client.
- [Removing power commands from the Start menu](start-menu-power-options-gpo/README.md): a GPO that removes the power commands from the Start menu of domain clients, with before and after screenshots.
- [Shared folder and drive mapping with Group Policy](shared-folder-drive-map-gpo/README.md): a shared folder with restricted permissions that is mapped as a network drive for domain users with a GPO.
- [Intranet on a Windows Server 2022 server](iis-intranet-server/README.md): installing IIS on a domain member server and publishing an intranet front page.
- [Backup and restore](backup-and-restore/README.md): a full server backup of a domain controller to a new disk and a System State restore in Directory Services Restore Mode after SYSVOL was damaged.
- [Blocking executable files on a file server](block-executable-files-fsrm/README.md): an active FSRM file screen that blocks .exe and .com files in a shared folder, tested from a domain workstation.
- [Preventing application installation with Group Policy](prohibit-user-installs-gpo/README.md): the Windows Installer policy Prohibit User Installs, enabled with Hide User Installs.
