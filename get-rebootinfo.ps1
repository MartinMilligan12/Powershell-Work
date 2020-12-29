$ComputerName = Read-Host "Enter server name"
$ReadEventid = Read-Host "Enter 1 for Reboot Times or 2 for Reboot Information; 3 for Dirty Shutdown"

Switch ($ReadEventid) {
	{$ReadEventid -eq 1} {$Eventid = 6005}
	{$ReadEventid -eq 2} {$Eventid = 1074}
	{$ReadEventid -eq 3} {$Eventid = 6008}
	}

# Parameters
# param
# (
# [string]$strHost
# )

# cls

# Check parameters input
if( $strHost -eq "" )
{
$res = "Missing parameters - Usage: .\rebootinfo.ps1 Computername"
echo $res
exit
}


# Get-WinEvent -Computername $strHost -FilterHashtable @{logname='System'; id=1074}  
Get-WinEvent -Computername $ComputerName -FilterHashtable @{logname='System'; id=$Eventid}|

# 6008 dirty shutdown
# 6005 eventlog started

ForEach-Object {

$rv = New-Object PSObject | Select-Object Date, User, Action, Process, Reason, ReasonCode, Comment

$rv.Date = $_.TimeCreated

$rv.User = $_.Properties[6].Value

$rv.Process = $_.Properties[0].Value

$rv.Action = $_.Properties[4].Value

$rv.Reason = $_.Properties[2].Value

$rv.ReasonCode = $_.Properties[3].Value

$rv.Comment = $_.Properties[5].Value

$rv

 } | Select-Object Date, Action, Reason, User