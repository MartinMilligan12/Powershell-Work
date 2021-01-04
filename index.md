* [Home](home)
* Quick Start Commands
  * [Users](Users)
  * [Computers](Computers)
  * [Groups](Groups)
* [Top 25 Powershell Commands](Top-25-Powershell-Commands)


### Get User Properties
`Get-ADUser -filter {(name -like "g*")} | select-object name`  
`Get-ADUser GlenJohn -Properties *`

### Create New Users
`> 1..10 |foreach-object {new-aduser -name "Sales$PSItem" -AccountPassword (ConvertTo-Securestring -AsPlainText "password" -force) -enabled:$true}`
 
### Find Users
`Get-ADUser -filter {name -like "s*" -and enabled -eq "false"}`

### Get List of Properties
`Get-ADUser -filter {city -eq "Miami"} | get-member`  
`Get-ADUser -f {name -like 'fpf1'}`  
`Get-ADUser -f {name -like 'fpf*'} select samaccountname`  
`Get-ADUser -f {name -like 'fpf*'} | select samaccountname`  
 
### Get list of Attributes from search
`Get-ADUser -filter {city -eq "Miami"} -Properties city, department | format-table -Property name, city, department`  
_Can use format-list or format-table_  
_**Use the * to get all users take out the city query**_ 

### Get Users Using Filter
`Get-ADUser -Filter * -SearchBase "OU=POS,DC=domain,DC=local" -Properties Created | Select-Object Name,Created | Sort-Object Created`  

`Get-ADUser -Filter * -SearchBase "OU=POS,DC=domain,DC=local" -Properties Created | Select-Object samaccountname, emailaddress, enabled | Sort-Object samaccountname | out-file pos.csv`  

`Get-ADUser -Filter * -SearchBase "OU=POS,DC=domain,DC=local" -Properties Created,emailaddress,msExchHomeServerName,enabled | Select-Object Name,Created,emailaddress,msExchHomeServerName,enabled | Sort-Object Created | export-csv POS.csv` 

### Lockout
`Get-ADUser -properties badpwdcount, lockedout %username`

### Last Logged on
`Get-ADUser -Filter * -SearchBase "DC=ds,DC=acme,DC=local" -Properties Created| Select-Object samaccountname | out-file domainusers_06_06.csv`  

`Get-ADUser -Filter * -SearchBase "DC=domain,DC=local" -Properties Created, emailaddress, lastlogondate | Select-Object samaccountname, enabled, emailaddress, lastlogondate | out-file domainusers_16_03.csv`  

`Get-ADUser -Filter * -SearchBase "DC=domain,DC=local" -Properties Created| Select-Object samaccountname, enabled | out-file domainusers14.csv`

### SMTP Address
<pre>
$logfile = 'c:\psexchange\postest.log'
"Executing" > $logfile
Import-CSV C:\scripts\domainusers20-11b.csv | ForEach-Object{ 
$user = Get-ADUser -Identity $_.samaccountname -Properties *
$primarySMTPAddress = ""
$last = $user.lastlogondate
foreach ($address in $user.proxyAddresses)
{
    if (($address.Length -gt 5) -and ($address.SubString(0,5) -ceq 'SMTP:'))
    {
        $primarySMTPAddress = $address.SubString(5)
        break
    }
}
$OFS = "`r`n"
$msg = $user.name, "; ",$primarySMTPAddress,  "; ",$user.lastlogondate,  "; ",$user.city,  "; ",$user.l,  "; ",$user.co  + $OFS
Write-Host $msg
}
</pre>


### msNPAllowDialin
`get-aduser -filter * -properties msNPAllowDialin | select name,samaccountname,msNPAllowDialin,enabled`  
`set-aduser samaccountname -replace @{msNPAllowDialIn=$true}`  
## Welcome to GitHub Pages

You can use the [editor on GitHub](https://github.com/MartinMilligan12/Powershell-Work/edit/gh-pages/index.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/MartinMilligan12/Powershell-Work/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
