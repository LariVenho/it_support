Import-Module ActiveDirectory
Import-Csv "C:\Scripts\uudet.csv" | ForEach-Object {
 $userPrincipal = $_."Kayttajatunnus" + "@server01.local"
New-ADUser -Name $_."Nayttonimi" `
 -Path ("OU=" + $_."Organisaatioyksikko" + ",OU=SERVER01,DC=server01,DC=local") `
 -SamAccountName $_."Kayttajatunnus" `
 -UserPrincipalName $userPrincipal `
 -GivenName $_."Etunimi" `
 -Surname $_."Sukunimi" `
 -DisplayName $_."Nayttonimi" `
 -AccountPassword (ConvertTo-SecureString $_."Salasana" -AsPlainText -Force) `
 -EmailAddress $_."Sahkopostiosoite" `
 -Company $_."Yritys" `
 -Department $_."Osasto" `
 -Title $_."Tyotitteli" `
 -ChangePasswordAtLogon $false `
 -Enabled $true
Add-ADGroupMember $_."Ryhma" $_."Kayttajatunnus";
}