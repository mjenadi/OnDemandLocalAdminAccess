#Return Current User

$key1 = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64)
$subKey1 = $key1.OpenSubKey(“SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI”)
$User = $subKey1.GetValue(“LastLoggedOnSAMUser")
# Use ‘SelectedUserSID‘ if this is AVD/VDI

#Add User
net localgroup administrators /add "$User"

# Create a tag file just so Intune knows this was installed
if (-not (Test-Path "$($env:ProgramData)\Microsoft\AddUserLocalAdmin"))
{
    Mkdir "$($env:ProgramData)\Microsoft\AddUserLocalAdmin"
}
Set-Content -Path "$($env:ProgramData)\Microsoft\AddUserLocalAdmin\AddUPNtoLocalAdminGroup.ps1.tag" -Value "Installed"