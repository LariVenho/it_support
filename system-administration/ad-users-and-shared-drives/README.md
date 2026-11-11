# AD-käyttäjät, kotihakemistot ja yhteiset asemat

Windows Server 2022 -ympäristön Active Directory -harjoitus (Keuda). Toimialue on `server01.local` ja palvelin `SERVER01`. Asiakaskoneena toimii Windows 11 -virtuaalikone.

## Kuvakaappaus

![Active Directory Users and Computers](images/ad-kayttajat-ja-ou.png)

*Active Directory Users and Computers: `server01.local` alla organisaatioyksikkö SERVER01 ja sen alla Hallinto, Helpdesk ja Opetus. Helpdesk-OU:ssa näkyvät Ylläpito-ryhmä (Security Group - Global) sekä käyttäjät Helena Kukkonen ja Lari Venho.*

## Organisaatioyksiköt ja ryhmät

| OU | Ryhmä |
|---|---|
| Helpdesk | Ylläpito |
| Hallinto | Hallinto |
| Opetus | Opiskelijat |

## Käyttäjät

| OU | Nimi | Ryhmät | Job Title | Logon script |
|---|---|---|---|---|
| Hallinto | Maija Mutikainen | Hallinto | Johdon assistentti | hallinto.bat |
| Hallinto | Risto Ratilainen | Hallinto | Johtaja | hallinto.bat |
| Hallinto | Simo Siili | Hallinto | Koulutuspäällikkö | hallinto.bat |
| Opetus | Jukka Mäntylä | Opiskelijat | opiskelija | oppilaat.bat |
| Opetus | Antti Ajattelija | Opiskelijat | opiskelija | oppilaat.bat |
| Helpdesk | Lari Venho | Ylläpito, Domain Admins, Enterprise Admins | ICT manager | PC.bat |
| Helpdesk | Helena Kukkonen | Ylläpito, Domain Admins | IT-tukihenkilö | PC.bat |

Jokaisen käyttäjän Profile-välilehdellä:
- **Logon script:** taulukon mukainen .bat-tiedosto
- **Home folder:** Connect `K:` to `\\SERVER01\homes\%username%`

## Jaetut kansiot (C:\)

| Kansio | Jako | Asema | Käyttöoikeudet |
|---|---|---|---|
| Homes | `\\SERVER01\homes` | K: (kotihakemisto) | Käyttäjä itse |
| Opiskelijat | `\\SERVER01\opiskelijat` | O: | Opiskelijat: muutos, Hallinto: luku, Ylläpito: täydet |
| Hallinto | `\\SERVER01\hallinto` | M: | Hallinto: täydet, Ylläpito: täydet |
| Util | `\\SERVER01\util` | Z: | Ylläpito: täydet |

## Kirjautumisskriptit

Skriptit on tehty Notepadilla ja tallennettu palvelimen NETLOGON-kansioon (`C:\Windows\SYSVOL\sysvol\server01.local\scripts`, verkosta `\\SERVER01\netlogon`). Kopiot ovat kansiossa [scripts](scripts/).

| Skripti | Käyttäjät | Liitettävät asemat |
|---|---|---|
| [PC.bat](scripts/PC.bat) | Ylläpito | O:, M:, Z: |
| [hallinto.bat](scripts/hallinto.bat) | Hallinto | O:, M: |
| [oppilaat.bat](scripts/oppilaat.bat) | Opiskelijat | O: |

Esimerkki, `PC.bat`:

```bat
@echo off
net use o: \\SERVER01\opiskelijat
net use m: \\SERVER01\hallinto
net use z: \\SERVER01\util
```
