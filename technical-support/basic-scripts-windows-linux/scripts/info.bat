@echo off
echo Computer Name is: %computername%
echo Windows version is:
ver
echo CPU is: %PROCESSOR_IDENTIFIER%
echo Total memory is:
rem Windows Management Instrumentation Command (WMIC) is a command line utility that can retrieve information about local or remote computers.
wmic ComputerSystem get TotalPhysicalMemory
echo The disks that are installed and their freespace:
wmic logicaldisk get size,freespace,caption
echo All the %computername% IP addresses
rem netsh is a command line scripting utility that allows the users to view or modify the network configurations of a running computer.
rem findstr is used for searching for a text string in files.
netsh interface ip show address | findstr "IP Address"
