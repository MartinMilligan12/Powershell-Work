$users = get-content  c:\pshell\expro\users.txt

Foreach ($user in $users) 
	{
	get-aduser $user -properties * | select emailaddress, AccountExpirationDate >> users2.txt
	}
