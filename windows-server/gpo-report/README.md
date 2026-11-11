# Creating a Group Policy report with PowerShell

Exporting the settings of all Group Policy Objects (GPOs) in the domain into one HTML report with PowerShell. The report is useful for documenting and reviewing which policies are in use.

## Steps

Run the commands in PowerShell as administrator on the domain controller.

1. Create the folder for the report in the root of the C: drive. The folder must exist before the report is created.

   ```powershell
   New-Item -Path C:\GPO_Reports -ItemType Directory
   ```

2. Create the report of all GPOs:

   ```powershell
   Get-GPOReport -All -ReportType Html -Path C:\GPO_Reports\AllGPOs.html
   ```

3. Open `C:\GPO_Reports\AllGPOs.html` in a browser to check the report, and submit the HTML file.

## What the report contains

`Get-GPOReport` collects the settings of every GPO in the domain into a single HTML file: the policy settings, where each GPO is linked and its security filtering. With `-ReportType Xml` the same information can be exported as XML. For a single policy, use `-Name` instead of `-All`.

## Lessons learned

- `Get-GPOReport` is part of the `GroupPolicy` PowerShell module, which is available on a domain controller or a computer with the Group Policy Management tools (RSAT).
- The command does not create the target folder, so it must be created first.
- The report shows details of the domain and its policies, so the HTML file itself is not published in this repository.
