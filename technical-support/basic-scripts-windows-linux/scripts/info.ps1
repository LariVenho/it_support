Write-Output "Computer name is:"
get-content env:computername
Write-Output "Windows version is:"
(Get-WmiObject -class Win32_OperatingSystem).Caption
Write-Output "CPU is:"
Get-WmiObject Win32_Processor | findstr "Name"
Write-Output "Total Memory is:"
[Math]::Round((Get-WmiObject -Class win32_computersystem -ComputerName localhost).TotalPhysicalMemory/1Gb)
Write-Output "The Disks that are installed and their freespace:"
Get-WmiObject -Class Win32_logicaldisk -Filter "DriveType = '3'"
Write-Output "IPv4 addresses"
Get-NetIPAddress -AddressFamily IPv4 | Sort-Object -Property InterfaceIndex | Format-Table
