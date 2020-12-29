$users = get-content  c:\pshell\acme\users.txt

Foreach ($user in $users) 
	{
	get-aduser $user -properties * | select emailaddress, AccountExpirationDate >> users2.txt
	}
