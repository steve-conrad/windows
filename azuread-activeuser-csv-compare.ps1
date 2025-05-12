### Compare CSV user list to Azure AD to audit active members ###

Connect-AzureAD

$Users = Import-Csv -Path "C:\Scripts\userlist.csv"

ForEach ($User in $Users) 
    {
    $UserInfo = Get-AzureADUser -SearchString $user.displayName
    Write-Host $UserInfo.displayName
    }
$EnabledADUsers = Get-AzureADUser -All $true -Filter "AccountEnabled eq true"

Compare-Object -ReferenceObject $Users -DifferenceObject $EnabledADUsers -Property Displayname