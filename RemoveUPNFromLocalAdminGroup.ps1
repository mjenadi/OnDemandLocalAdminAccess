#Return Current User

$key1 = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64)
$subKey1 = $key1.OpenSubKey(“SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI”)
$User = $subKey1.GetValue(“LastLoggedOnSAMUser")

#Remove User

net localgroup administrators /delete "$User"

#Delete detection 

Remove-Item "$($env:ProgramData)\Microsoft\AddUserLocalAdmin\AddUPNtoLocalAdminGroup.ps1.tag" -recurse -force