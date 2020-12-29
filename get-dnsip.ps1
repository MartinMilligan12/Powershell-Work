get-content C:\pshell\expro\tmp.txt | foreach-object {

$server = $_

$_
invoke-command -computername $_ {get-dnsclientserveraddress}
 }