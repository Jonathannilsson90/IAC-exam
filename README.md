# IAC-Inlämning

## Starta projektet

Projektet körs lokalt och använder Docker, Terraform, Ansible och Python. Kontrollera att Docker-daemonen är igång. Starta sedan menyprogrammet från projektroten:

```bash
./run.sh
```

1. **Kontrollera beroenden:** Välj **1**. Skriptet kontrollerar Terraform, Ansible, Docker och Python 3. Om något saknas kan det erbjuda installation via `apt`; Terraform hämtas via HashiCorps installationsskript.
2. **Starta webbservern:** Välj **2**. Terraform initieras och skapar Nginx-containern `nginx` från imagen `nginx:latest`. Port 80 publiceras på `127.0.0.1:8080`. Öppna [http://localhost:8080](http://localhost:8080) för att se sidan.
3. **Konfigurera containern:** Välj **4**. Ansible kör playbooken mot Docker-containern enligt `ansible/inventory.ini` och installerar Python 3 och curl.
4. **Kör testerna:** Välj **5**. Projektet skapar `.venv` vid behov och kör pytest-kontrollerna.
5. **Ta bort resurserna:** Välj **3** när du är klar. Terraform tar då bort containern och övriga resurser som den hanterar.
6. **Avsluta:** Välj **q** för att stänga menyn.

Terraform använder katalogen `html/` som skrivskyddad volym i Nginx. Ändringar i `html/index.html` visas därför på webbplatsen utan att filen behöver kopieras in i containern. Terraform-konfigurationen finns i `infra/` och använder Docker-providern.

## Projektets mål

Målet är att visa ett enkelt Infrastructure as Code-flöde där en webbserver skapas reproducerbart med Terraform och konfigureras med Ansible. En lokal HTML-sida serveras av Nginx i en Docker-container. Pytest används för att kontrollera att servern svarar och att förväntat innehåll finns på sidan.

## Metoder

- **Terraform** beskriver Nginx-imagen och containern, portmappningen samt den skrivskyddade bind-mounten av `html/`.
- **Ansible** ansluter till containern via Docker-inventory-pluginen och installerar Python 3 och curl.
- **Bash**-menyn i `run.sh` samlar beroendekontroll, Terraform-kommandon, Ansible-körning och tester på ett ställe. Terraform-loggar sparas under `logs/`.
- **pytest** kontrollerar HTTP-status på `localhost:8080`, sidans rubrik och att en viss paragraf saknas. Ett test verifierar även att curl går att hitta i containern.

## Resultat

Efter en lyckad driftsättning visas sidan från `html/index.html` på `http://localhost:8080`. Den innehåller rubriken **“Terraform made this possible”**. Testerna kontrollerar att sidan ger HTTP 200, att rubriken finns, att den oönskade paragrafen saknas och att curl är installerat i containern.

Resultatet kan verifieras genom att välja **5** i menyn efter att containern har startats och Ansible har körts. Tester och driftsättning förutsätter att port 8080 är ledig och att Docker fungerar lokalt.

## Reflektion

En svårighet var att bygga upp Bash-skriptet så att funktionerna i `lib/` kunde återanvändas. Skripten behöver hämtas in med `source` innan deras funktioner kan anropas. För att det ska fungera oavsett vilken katalog projektet startas från använder skripten sökvägar som räknas fram från respektive skriptfil, i stället för att förlita sig på den aktuella katalogen. Det gjorde också ordningen mellan `source`-anropen viktig: beroenden som `install_packages.sh` använder måste finnas tillgängliga.

Jag gjorde också en tankevurpa kring Ansible och `localhost`. Jag tänkte först att målet skulle behöva en extern IP-adress. I det här projektet körs Ansible lokalt och inventory-filen anger `ansible_connection=community.docker.docker`, så Ansible använder Docker-anslutningen för att nå containern. `ansible_host=nginx` syftar på containernamnet; någon extern IP-adress behövs därför inte. `localhost` är maskinen som kör Ansible, medan den faktiska målmiljön är Docker-containern.

Projektet visar hur infrastruktur och grundläggande konfiguration kan beskrivas som kod och köras med ett samlat kommandogränssnitt. Den separata HTML-katalogen gör det enkelt att ändra webbplatsens innehåll, medan automatiska kontroller fångar flera vanliga fel efter driftsättning.

En möjlig förbättring är att göra Ansible-playbooken mer idempotent och anpassad efter den valda basimagen, samt att låta skriptet hantera fel från varje kommando tydligare. Beroendelistan i `requirements.txt` kan också begränsas till projektets faktiska Python-behov för att göra testmiljön enklare att återskapa.

[Github repo](https://github.com/Jonathannilsson90/IAC-exam)
