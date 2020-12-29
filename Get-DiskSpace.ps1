$ComputerName = Read-Host "Enter server name"
# $sql = get-ciminstance -class win32_logicaldisk -computername $ComputerName
$sql = get-wmiobject -class win32_logicaldisk -computername $ComputerName

$free = $sql | foreach { ($_.FreeSpace) }
$size = $sql | foreach { ($_.Size) }
$letter = $sql | foreach { ($_.deviceid) }

$count = $Free | measure

$loop = $size.count
$test = @("0") * $loop
$percent = @("0") * $loop
$percentshow = @("0") * $loop

get-adcomputer $ComputerName -property * | select name, description
For ($i=0;$i -lt $loop;$i++) {
    if ($free[$i] -ne $null) {
       $percent[$i] = ($free[$i]/$size[$i]) * 100
       $percent[$i] = [math]::round($percent[$i])
       $percentshow[$i] = "$percent[$i], '%'"
       $Size[$i] = [math]::round($Size[$i]/1073741824)
       # write-output $letter[$i], $percent[$i]
       # $letter[$i], $percent[$i]
       write-output "$($letter[$i]) $($percent[$i])$('%') $('Free') $('****') $('Disk Size:') $($Size[$i])$('GB')"
       
       # $test[$i]= $letter[$i], $percent[$i]
       }
    } 
