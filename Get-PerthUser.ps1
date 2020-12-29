import-module ActiveDirectory
Get-ADUser -Filter * -Searchbase "OU=Users,OU=Perth,OU=Asia Pacific,OU=Acme International Group,DC=Acme,DC=Local" -properties * | select -expand emailaddress | sort emailaddress | out-file PerthUsers.txt
get-content c:\scripts\perthusers.txt | get-mailbox | Get-MailboxStatistics | Sort-Object LastLogonTime -Descending | select displayname, lastlogontime | ConvertTo-Html -Head "PERTH USERS - Last Logon Time" -AS Table | out-file Perth_Users.html
