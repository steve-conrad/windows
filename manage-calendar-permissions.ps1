#Manage User Calendar Specific Permissions

#Set execution policy to import exchange module
Set-ExecutionPolicy RemoteSigned -Force

#Import Exchange module
Import-Module ExchangeOnlineManagement

#Connect to exchange
Connect-ExchangeOnline

#View Calendar permissions
Get-MailboxFolderPermission -Identity username:\Calendar

#Add Calendar permissions
Add-MailboxFolderPermission -Identity username@domain.com:\calendar -user username@domain.com -AccessRights Editor

#Remove Calendar permissions
Remove-MailboxfolderPermission -Identity username@domain.com:\calendar -user username@domain.com