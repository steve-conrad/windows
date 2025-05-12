Install-Module -Name ImportExcel -Scope CurrentUser
$excel = Import-Excel -Path 'C:\userlistname.xlsx'
$upns = $excel.'PrimaryUserUPN'

Connect-AzureAD

$newGroup = New-AzureADGroup -DisplayName 'yourgroupname' -SecurityEnabled $true -MailEnabled $false 
  
foreach ($upn in $upns) 
{  
    $user = Get-AzureADUser -ObjectId $upn  
    if ($user) {  
        Add-AzureADGroupMember -ObjectId $newGroup.ObjectId -RefObjectId $user.ObjectId  
    } else {  
        Write-Output "User $upn not found"  
    }  
}  