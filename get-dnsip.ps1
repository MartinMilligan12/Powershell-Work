get-content C:\pshell\acme\tmp.txt | foreach-object {

$server = $_

$_
invoke-command -computername $_ {get-dnsclientserveraddress}
 }
