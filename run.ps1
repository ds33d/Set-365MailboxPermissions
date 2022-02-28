function Set-365EmailPermissions($Identity, $EmailAddress, $User, $List){
    #Install-Module ExchangeOnlineManagement
    Import-Module ExchangeOnlineManagement
    if ($Identity -eq $null){}
    else{Connect-ExchangeOnline -UserPrincipalName $Identity}

    if($List -ne $Null){
        foreach ($person in $List){Add-MailboxPermission $EmailAddress -User $person -AccessRights FullAccess
        Write-Host "$person has been given FullAcess to $EmailAddress" -ForegroundColor Green
        }
    }
    else
    {
        Add-MailboxPermission $EmailAddress -User $User -AccessRights FullAccess
    }
    
    Get-MailboxPermission $EmailAddress | where {$_.User -like "*$User*"} | Format-Table -Auto User,Deny,IsInherited,AccessRights

    Write-Host "$User has been given FullAcess to $EmailAddress"
}
