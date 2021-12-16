# Vision Airport project: handleiding

<br>

**TODO**
*Youssef*
- [ ] Create and cleanse all tables algemeen (Youssef)

*Lina*
- [ ] Cleaning: foreign keys
- [ ] SSMS: create DWH tables
- [ ] SSIS: zuivere data in DWH laden

*Wout*
- [ ] Dashboard PowerBI

*Jonas*
- [ ] Documentatie
- [ ] Powerpoint

*Algemeen + eventueel nog te cleanen*

- [ ] UTF-8 varchar string decoden > if ASCII or null > do nothing
- [ ] Delete duplicates luchthavens

# Introductie
In deze handleiding wordt er stap voor stap uitgelegd hoe je dit project op je lokale machine kan opstellen. De handleiding bestaat uit vijf stappen:
1. [Nodige software](#software)
2. [Database setup](#databasesetup)
3. [Data importing](#raw)
4. [Data cleaning](#cleansed)
5. [Data Warehouse](#dwh)
6. [Data inladen in DWH met SSIS](#ssis)
7. [Analyseren met PowerBI](#powerbi)

<br>

## Nodige software <a name="software"></a>
- SQL Server Management Studio (SSMS)
- Visual Studio 2019
- Microsoft Power BI

<br>

## Database setup <a name="databasesetup"></a>
De eerste stap is het creëren van de OLTP database en de verschillende schema's. Voer de [Database_Setup.sql](./scripts/Database_Setup.sql) script uit in SSMS om de *RAW*, *CLEANSED* en *ARCHIVE* schema's en de *VisionAirport_OLTP* database aan te maken.

<br>

## Data importing <a name="raw"></a>
Nadat de schema's en de VisionAirport_OLTP database zijn aangemaakt, importeren we de flat files. Deze import gebeurd via Import Wizard in SSMS.
Volg deze stappen voor elke flat file:
1. Right click *VisionAirport_OLTP* database > Tasks > Import Flat File...
2. Klik op Browse.. > ga naar de locatie van de flat file > Open
3. Geef de tabel een naam (optioneel) en kies als Table schema *RAW*
5. Klik twee keer op Next
6. Verander het Data Type voor elke kolom-naam naar **nvarchar(50)** en vink Allow Nulls aan voor alle kolommen
7. Klik op Next en dan op Finish
>Let op: In de flat file "exports_luchthavens.txt" moet je de eerste kolom op **nvarchar(MAX)** zetten in plaats van nvarchar(50).

<br>

## Data cleaning <a name="cleansed"></a>
In de [Database_Setup](#databasesetup) hebben we in de VisionAirport_OLTP database drie schema's aangemaakt. In de volgende stappen gaan deze schema's elk een andere functie hebben. De verschillende schema's en hun funtie worden hier uitgelegd:
- **RAW**: de één op één data die we in de *Data importing* hebben ingeladen.
- **CLEANSED**: de data die écht van belang is en *gecleaned* is. We gebruiken deze data voor de DWH.
- **ARCHIVED**: alle data van de RAW schema die nutteloos of corrupt is.

Om de data in de juiste schema's te krijgen moeten er een aantal queries uitgevoerd worden. Deze queries vind je in de [scripts](./scripts) folder en worden in twee stappen uitgevoerd:
<br>
1. Voer de [Create_Cleansed_Tables.sql](./scripts/Create_Cleansed_Tables.sql) script uit in in SSMS. Deze script maakt alle CLEANSED-tabellen aan met de juiste datatypes.
2. Voer alle [Cleanse_*.sql](./scripts) scripts uit in SSMS. 
Deze scripts vullen alle CLEANSED-tabellen met de data van de RAW schema. De data wordt hier gecleaned door de datatypes in het juiste type te converteren, PK's en FK's toe te voegen en alle duplicates, irrelevante data en corrupte data er uit te halen.
>Momenteel maakt de volgorde waarin we de cleanse_*.sql scripts uitvoeren nog niet uit omdat we nog geen FK's gelegd hebben. Eens dit gebeurd is passen we dit aan in deze README.md.
3. Voer de [Create_Archive.sql](./scripts/Create_Archive.sql) script uit in SSMS. Deze script kopieert de structuur van de RAW-schema. De duplicates, irrelevante data en corrupte data komt hierin terecht.

<br>

## Data Warehouse creatie scripts <a name="dwh"></a>
In deze stap beginnen we aan de DWH. Om data vanuit SSIS terug in te laden in SSMS moeten we volgende stappen uitvoeren:
1. Maak in SSMS een nieuwe database aan genaamd *VisionAirport_DWH*. In deze database gaan we zuivere data inladen.
2. Voer de [Create_DWH_Tables.sql](./scripts/Create_DWH_Tables.sql) script uit in de *VisionAirport_DWH* database.
> Script bestaat nog niet. Enkel nog gedaan voor Vlucht.

## Data inladen in DWH met SSIS <a name="ssis"></a>
Eerst Full Load, dan Incremental Load.

Done: 
- Add TRUNCATE script
- Om te vermijden dat bij elke start alles in de control flow tegelijk wordt uitgevoerd: add arrows in SSIS
<br>

## Analyseren met PowerBI <a name="powerbi"></a>
Aan de hand van de data die ingeladen werd in het datawarehouse, maken we het dashboard.
<br>
