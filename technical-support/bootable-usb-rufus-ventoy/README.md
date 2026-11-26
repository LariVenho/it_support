# Bootable USB media with Rufus, Ventoy and Media Creation Tool (Lenovo ThinkPad P52s)

Documentation of how bootable 32 GB USB drives were made and used to install Ubuntu 26.04 LTS and Windows 11 on a Lenovo ThinkPad P52s, using Rufus on Windows, Ventoy on Ubuntu and Microsoft's Media Creation Tool on Windows.

| | |
|---|---|
| **Device** | Lenovo ThinkPad P52s (UEFI boot, 1 TB WD Green SN350 NVMe drive) |
| **Task** | Create bootable USB media with three different tools and install an operating system from them |
| **Date** | November 2026 |
| **Performed by** | Lari Venho |
| **Result** | ✅ All three USB drives booted and the installations worked (a Secure Boot error with Ventoy was solved, see [Troubleshooting](#troubleshooting)) |

---

## Table of contents

1. [Objective](#objective)
2. [Tools](#tools)
3. [Part 1: Ubuntu USB with Rufus](#part-1-ubuntu-usb-with-rufus)
4. [Part 2: Windows 11 USB with Ventoy](#part-2-windows-11-usb-with-ventoy)
5. [Part 3: Windows 11 USB with Media Creation Tool](#part-3-windows-11-usb-with-media-creation-tool)
6. [Troubleshooting](#troubleshooting)
7. [Lessons learned](#lessons-learned)

---

## Objective

Learn three ways of creating bootable USB media and compare them:

- **Rufus** writes one ISO image to the drive and erases everything on it.
- **Ventoy** is installed to the drive once, after which ISO files are simply copied to it as normal files. The same drive can hold several ISO images and ordinary files.
- **Media Creation Tool** is Microsoft's own tool. It downloads Windows 11 and writes it to the drive in one go.

## Tools

| Tool | Version | Used on |
|---|---|---|
| Rufus (portable) | 4.16 | Windows 11 |
| Ventoy (Ventoy2Disk GUI) | 1.1.18 | Ubuntu 26.04.1 LTS |
| Media Creation Tool | | Windows 11 |
| Ubuntu desktop ISO | 26.04.1 LTS amd64 | |
| Windows 11 ISO | | |
| USB drive | 32 GB | |

> All three tools erase the drive, so anything important on it must be backed up first. Rufus needs administrator rights.

---

## Part 1: Ubuntu USB with Rufus

1. Open Rufus and select the 32 GB USB drive as the **Device**.
2. Under **Boot selection**, select `ubuntu-26.04.1-desktop-amd64.iso`.
3. Settings used:
   - Partition scheme: **MBR**
   - Target system: **BIOS or UEFI**
   - File system: **FAT32**, cluster size 16 kilobytes
   - Persistent partition: none
4. Press **START**. Rufus writes the ISO to the drive.

![Rufus settings](images/15-rufus-ready.jpg)

### Booting from the USB drive

Press F12 at startup to open the boot menu. The drive appears as **USB HDD: USB SG Flash**.

![Boot menu](images/12-boot-menu-usb-selected.jpg)

The Ubuntu USB drive opens the GRUB menu, and from there the Ubuntu installer starts.

![GRUB menu](images/11-grub-try-or-install.jpg)

![Ubuntu installer](images/10-ubuntu-installer-language.jpg)

---

## Part 2: Windows 11 USB with Ventoy

From the Ubuntu installation, Ventoy was installed on the same USB drive:

1. Download and extract `ventoy-1.1.18`, then run `VentoyGUI`.
2. Select the USB drive (`sdb [32 GB] USB SG Flash`), partition style MBR, and press **Install**.
3. Copy `Windows11.iso` to the Ventoy partition of the drive.
4. Run `sync` in a terminal before removing the drive, so that all data has been written.

![Ventoy2Disk](images/08-ventoy2disk-linux-gui.jpg)

After booting from the drive, the Ventoy menu lists the ISO file:

![Ventoy menu](images/05-ventoy-menu.jpg)

### Windows 11 installation

In the Windows 11 setup, **Install Windows 11** was selected. This option erases all content, including files, apps and settings.

![Installation option](images/03-windows11-install-option-checked.jpg)

The installation location screen shows both the laptop's internal drive (disk 0) and the Ventoy USB drive (disk 1, with the `Ventoy` and `VTOYEFI` partitions). The installation must target the internal drive, not the USB drive.

![Partitions](images/02-windows11-installer-partitions.jpg)

Ubuntu was already installed on the internal drive, and Windows could not be installed while its partitions were in the way (the setup warned that Windows 11 cannot be installed on the selected partition). To make room, the partitions where Ubuntu was installed had to be deleted in the installer (**Delete partition**), after which the unallocated space was selected as the installation target and Windows 11 installed there. This permanently removed the Ubuntu installation from the drive.

Result: Windows 11 installed and running.

![Windows 11 desktop](images/01-windows11-desktop.jpg)

---

## Part 3: Windows 11 USB with Media Creation Tool

Microsoft's Media Creation Tool downloads Windows 11 and writes it to a USB drive, so no separate ISO file and no second tool is needed. The tool was run on a Windows 11 PC and it needs an internet connection while it creates the media.

1. Run `MediaCreationTool.exe`.

   ![Media Creation Tool on the desktop](images/16-media-creation-tool-desktop.jpg)

2. On the **Choose which media to use** page, select **USB flash drive** (at least 8 GB of free space is needed). The other option, **ISO file**, only saves an ISO file that would have to be burned to a DVD later.

   ![Choose media](images/17-media-creation-tool-choose-usb.jpg)

3. When the tool has finished, it reports that the USB flash drive is ready and shows the drive letter (`D:\`).

   ![USB drive ready](images/18-media-creation-tool-usb-ready.jpg)

### Booting from the USB drive

Press F12 at startup to open the boot menu and select **USB HDD: USB SG Flash**. The menu also lists the internal drive (`NVMe0: WD Green SN350 1TB`), network boot (`PCI LAN`) and the entries **Windows Boot Manager** and **Ubuntu**, which remain from the earlier installations.

![Boot menu](images/19-boot-menu-media-creation-tool-usb.jpg)

### Windows 11 installation

In the Windows 11 setup, **Install Windows 11** was selected. The checkbox below it confirms that all content, including files, apps and settings, will be removed.

![Install option](images/20-windows11-setup-install-option.jpg)

On the installation location screen, the internal drive (disk 0) shows 931.5 GB of unallocated space, because its old partitions had been deleted. The USB drive appears as disk 1, partition 1, and it has the volume label `ESD-USB`, which is the label the Media Creation Tool gives to the drive. The unallocated space on disk 0 was selected as the target, not the USB drive.

![Install location](images/21-windows11-setup-install-location.jpg)

After that the installation started. The setup copies the files and restarts the computer several times.

![Installing Windows 11](images/22-windows11-installing.jpg)

Result: Windows 11 installed on the internal drive.

---

## Troubleshooting

### Secure Boot: `Verification failed: (0x1A) Security Violation`

The first boot from the Ventoy drive stopped with this error.

![Security violation](images/06-ventoy-security-violation.jpg)

**Cause:** Secure Boot does not trust the Ventoy boot loader by default.

**Solution:** The key that is included on the Ventoy USB drive was enrolled on the laptop (MOK enrollment). After that, Ventoy booted with Secure Boot still enabled. The other option would have been to disable Secure Boot temporarily in the BIOS.

---

## Lessons learned

- Rufus is the simplest choice for a single ISO. Ventoy is better when one drive should hold several ISO images or files larger than 4 GB, because its data partition is not limited by FAT32.
- FAT32 limits single files to 4 GB. Rufus works around this for the Ubuntu ISO, which is why the file system can stay FAT32.
- Secure Boot can block third-party boot loaders such as Ventoy. The error `0x1A Security Violation` is the typical sign, and enrolling the key solves it without turning Secure Boot off.
- An existing Ubuntu installation has to be removed (its partitions deleted) before Windows can be installed on the same drive. Deleting partitions destroys the data on them, so back up anything needed first.
- Always check which drive the installer targets, because the USB drive appears in the same list as the internal drive.
- Back up the USB drive first. All three tools wipe it.
- Media Creation Tool is the simplest way to make Windows 11 media, because it downloads and writes in one step. It can only make Windows media, it needs an internet connection and it offers just two targets: a USB drive or an ISO file. Rufus and Ventoy work with any ISO file, including Linux images.
- Old boot entries stay in the computer's firmware even after the drive has been wiped. The `Ubuntu` entry still appeared in the boot menu after Ubuntu had been removed. It is harmless, and the entry can be removed in the firmware setup.
