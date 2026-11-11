# PowerShell: files and folders

A PowerShell exercise on a Windows 11 virtual machine, run as administrator. The commands are used to create, copy, move and remove files and folders, to look up aliases and help, to write and run a small script and to record the whole session with a transcript.

The full session is saved as a transcript: [PSscript1.txt](PSscript1.txt).

## Steps

### 1. Working folder and transcript

The session starts in `C:\` and is recorded with `Start-Transcript`. The transcript file is stored in the `demo3` folder of the user's home folder:

```powershell
Set-Location C:\
Start-Transcript -Path $HOME\demo3\PSscript1.txt
```

`Stop-Transcript` ends the recording. To continue an existing transcript, add `-Append`, otherwise the old file is overwritten.

### 2. Aliases and help

```powershell
Get-Alias cd                           # cd -> Set-Location
Get-Alias md                           # md -> mkdir
Get-Help New-Item
Get-Alias -Definition Get-ChildItem    # dir, gci, ls
Get-Alias -Definition Set-Location     # cd, chdir, sl
```

### 3. Folders and files

```powershell
New-Item -ItemType directory -Name scripts
Set-Location .\scripts\
New-Item -ItemType directory -Name demo
Set-Location .\demo\
echo "This is my file" > myfile.txt
Write-Output "This is my third file." | Out-File myfile3.txt
Get-Content myfile.txt
New-Item -ItemType Directory -Name "New Folder"
Copy-Item myfile.txt ".\New Folder\"
```

A name that contains a space, such as `New Folder`, must be written in quotation marks.

### 4. A script

`notepad myscript.ps1` creates the script file, which writes two messages, creates the folder `My Folder` and three text files in it, and lists the folder:

```powershell
Write-Output "This is my first Powershell script myscript.ps1"
Write-Output "Create a new folder and some new files there."
New-Item -ItemType Directory "My Folder"
Set-Location '.\My Folder'
Get-ChildItem
Write-Output "This is my first new file" | Out-File newfile1.txt
Write-Output "This is my second file in My Folder." | Out-File newfile2.txt
Write-Output "This is my third file." | Out-File newfile3.txt
Get-ChildItem
Set-Location ..
```

Running the script first fails because the execution policy does not allow scripts. The policy is changed for the test and set back afterwards:

```powershell
.\myscript.ps1                       # error: running scripts is disabled on this system
Set-ExecutionPolicy bypass
.\myscript.ps1
Set-ExecutionPolicy Restricted
```

### 5. Copying, moving and removing

```powershell
Copy-Item '.\My Folder\newfile3.txt' newfile3_copy.txt
md ..\demo2
Copy-Item '.\My Folder\' ..\demo2\ -Recurse
Remove-Item * -WhatIf                                     # shows what would be removed
Move-Item '.\My Folder\newfile1.txt' '.\New Folder\'
Remove-Item '..\demo2\My Folder\' -WhatIf
Remove-Item '..\demo2\My Folder\'                         # asks for confirmation because the folder has children
Get-ChildItem ..\demo2                                    # the folder is empty
```

## Lessons learned

The transcript also shows the mistakes made during the session and how they were fixed:

- A command that is misspelled (`Get-Help new-iten`, `get-alis`, `Stop-Transript`) fails with *The term ... is not recognized*. Check the spelling, and use `Stop-Transcript` to end the transcript.
- `cd New Folder` fails because of the space in the name. Use `cd "New Folder"`.
- A script in the current folder must be started with `.\myscript.ps1`. Without `.\` PowerShell does not find it.
- Scripts are blocked by the default execution policy. `Set-ExecutionPolicy bypass` allows them for the test, and `Set-ExecutionPolicy Restricted` restores the safe setting.
- `-WhatIf` shows what a command would do without doing it. It is useful before `Remove-Item`.
- A relative path depends on the current folder. `Get-Content '.\My Folder\newfile.txt'` failed because the file name was wrong and the current folder was `My Folder` itself.
