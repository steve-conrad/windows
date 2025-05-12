#Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All"

#Get the group name and its members. Change the groupName value in quotes to the group name you want to audit.
$groupName = "yourgroupname"
$group = Get-MgGroup -Filter "displayName eq '$groupName'"
$members = Get-MgGroupMember -GroupId $group.Id

# Initialize lists for active and inactive users
$activeUsers = @()
$inactiveUsers = @()

# Check if users are active
foreach ($member in $members) {
    $user = Get-MgUser -UserId $member.Id -Property "AccountEnabled,DisplayName"
    if ($user.AccountEnabled) {
        $activeUsers += $user.DisplayName
    } else {
        $inactiveUsers += $user.DisplayName
    }
}

# Output the results
Write-Output "Active Users:"
$activeUsers | ForEach-Object { Write-Output $_ }
Write-Output "`nInactive Users:"
$inactiveUsers | ForEach-Object { Write-Output $_ }