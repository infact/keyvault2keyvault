import-module AzureRM.keyvault

$sourceVaultName = $args[0]
$destVaultName = $args[1]

#Authenticate user
Connect-AzureRmAccount

#access secret values one by one 
$names = (Get-AzureKeyVaultSecret -VaultName $sourceVaultName | select Name)

$i=0
do {
   $rawSecret = (Get-AzureKeyVaultSecret -VaultName $sourceVaultName -Name $names[$i].Name).SecretValueText
   $AKVsecret = ConvertTo-SecureString $rawSecret -AsPlainText -Force
   Set-AzureKeyVaultSecret -VaultName $destVaultName -Name $names[$i].Name -SecretValue $AKVsecret
   $i++
} while($i -lt $names.length)
