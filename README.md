# OnDemandLocalAdminAccess
Using Azure identiy Gouvernance and a Win32 Package to delegate Local Administrator permissions for Hybrid AAD Devices

You can refer to this site to discover the solution : 

https://sccmf12twice.com/2022/02/on-demand-local-admin-access-with-intune/

the only difference is instead of using Intune account proctection policy where we meet some limits for Hybrid AAD Devices, we replace this policy by a Win32 Package.

The needed is when User request the access package permission the Win32 package have to switch to required and intall it, when user lost his permission the Win32 package have to be uninstalled.

For that we can refer to this docs table "How conflicts between app intents are resolved" :

Group 1 intent	  Group 2 intent	   Resulting intent
User    Required	User    Available	 Required and Available
User    Required	User    Uninstall	 Required
User    Available	User    Uninstall	 Uninstall

https://docs.microsoft.com/en-us/mem/intune/apps/apps-deploy

We will use a simple script to add the current user to the local admin group AddUPNtoLocalAdminGroup.ps1
when user will lost his permission we will a second script to remove the current user from local admin group RemoveUPNFromLocalAdminGroup.ps1.

the Win32 package is uploaded we have just to create the application in Intune with this informations :

Install command :
powershell.exe -noprofile -executionpolicy bypass -file .\AddUPNtoLocalAdminGroup.ps1
Uninstall command :
powershell.exe -noprofile -executionpolicy bypass -file .\RemoveUPNFromLocalAdminGroup.ps1
Install behavior : System 


Detection Rule : 

Rule Type : Path
Path : %ProgramData%\Microsoft\AddUserLocalAdmin
File or Folder : AddUPNtoLocalAdminGroup.ps1.tag
Detection Method : File or Folder Exists

Assignement : 

Required : Included the targeted AAD Group in the access package ressources
available : None
Uninstall : Included All users



