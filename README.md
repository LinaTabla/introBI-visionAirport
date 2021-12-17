# Vision Airport project: handleiding
In deze handleiding wordt er stap voor stap uitgelegd hoe je dit project op je lokale machine kan opstellen en uitvoeren. 

<br>

**Installeer vooraf onderstaande software:**
- SQL Server Management Studio (SSMS)
- Visual Studio 2019
  - SQL Server Integration Services
- Microsoft Power BI

<br>

**De handleiding bestaat uit vijf stappen:**
1. [Database setup](#databasesetup)
2. [Data importing](#raw)
3. [Data cleansing](#cleansing)
   * [Cleansed scripts](#cleansed)
   * [Archive scripts](#archive)
5. [Datawarehouse](#dwh)
   * [DWH setup in SSMS](#ssms)
   * [Data inladen in DWH met SSIS](#ssis)
6. [Analyseren met PowerBI](#powerbi)

<br>

## Database setup <a name="databasesetup"></a>
In dit project maken we gebruik van twee databases: *VisionAirport_OLTP* en *VisionAirport_DWH*.
De *VisionAirport_OLTP* heeft daarbovenop drie schema's waarin we gaan werken.
<br>

Voer de [Database_Setup.sql](./Scripts/Database_Setup.sql) script uit in SSMS om:
- de **VisionAirport_DWH** database aan te maken (= destination database)
- de **VisionAirport_OLTP** database aan te maken (= source database) 
- in de **VisionAirport_OLTP** database de schema's **RAW**, **CLEANSED** en **ARCHIVE** aan te maken

<br>

## Data importing <a name="raw"></a>
Nadat de *VisionAirport_OLTP* database en zijn schema's zijn aangemaakt, is de volgende stap het importeren van de flat files. Deze import gebeurd via de *Import Wizard* in SSMS.
Volg deze stappen voor elke flat file:
1. Right click *VisionAirport_OLTP* database > Tasks > Import Flat File... > Next
2. Klik op Browse.. > ga naar de locatie van de flat file > Open
3. Pas de naam van de tabel niet aan en kies als Table schema *RAW*
5. Klik twee keer op Next
6. Verander het Data Type voor elke kolom-naam naar **nvarchar(50)** en vink **Allow Nulls** aan voor alle kolommen
7. Klik op Next > Finish > Close
>Let op: bij import van de **exports_luchthavens.txt** file moet je het datatype van de kolom **Airline** op **nvarchar(MAX)** zetten in plaats van nvarchar(50).
>
>Let op: bij import van de **exports_vliegtuigtype.txt** file moet je het datatype van de kolom **Type** op **nvarchar(100)** laten.

<br>

## Data cleaning <a name="cleansing"></a>
In de [database setup](#databasesetup) hebben we in de *VisionAirport_OLTP* database drie schema's aangemaakt die elk een andere functie hebben:
| Schema        | Functie |
| --- | ---|
| **RAW** | De één op één data die we in de [data importing](#raw) hebben ingeladen. |
| **CLEANSED** | De data die écht van belang is en *gecleaned* is. De gezuiverde data wordt gebruikt voor de [DWH](#dwh). |
| **ARCHIVED** | Alle data van de RAW schema die nutteloos, dubbel of corrupt is. |

Om de data in de juiste schema's te krijgen moeten er een aantal scripts uitgevoerd worden in SSMS. Deze scripts vind je in de [*Scripts*](./Scripts) folder.

### Cleansed scripts <a name="cleansed"></a>
In de [CLEANSED](./Scripts/CLEANSED) folder staan alle scripts die invloed op hebben op de CLEANSED-schema. Voer de scripts uit in SSMS in deze volgorde:
1. [Create_Cleansed_Tables.sql](./Scripts/CLEANSED/Create_Cleansed_Tables.sql) : deze script maakt alle CLEANSED-tabellen aan met de juiste datatypes.
2. Voer deze scripts in de [CLEANSED](./Scripts/CLEANSED) folder uit volgens deze volgorde:
- [Cleansed_Maatschappijen.sql](./Scripts/CLEANSED/Cleansed_Maatschappijen.sql)
- [Cleansed_Vliegtuigtype.sql](./Scripts/CLEANSED/Cleansed_Vliegtuigtype.sql)
- [Cleansed_Vliegtuig.sql](./Scripts/CLEANSED/Cleansed_Vliegtuig.sql)
- [Cleansed_Vlucht.sql](./Scripts/CLEANSED/Cleansed_Vlucht.sql)
- [Cleansed_Banen.sql](./Scripts/CLEANSED/Cleansed_Banen.sql)
- [Cleansed_Aankomst.sql](./Scripts/CLEANSED/Cleansed_Aankomst.sql)
- [Cleansed_Vertrek.sql](./Scripts/CLEANSED/Cleansed_Vertrek.sql)
- [Cleansed_Klant.sql](./Scripts/CLEANSED/Cleansed_Klant.sql)
- [Cleansed_Luchthavens.sql](./Scripts/CLEANSED/Cleansed_Luchthavens.sql)
- [Cleansed_Planning.sql](./Scripts/CLEANSED/Cleansed_Planning.sql)
- [Cleansed_Weer.sql](./Scripts/CLEANSED/Cleansed_Weer.sql)

Deze scripts vullen alle tabellen in de CLEANSED-schema met de data van de RAW-schema. Echter wordt de data wordt hier ook gecleaned door het het te converteren naar het juiste datatype, PK's en FK's toe te voegen en alle duplicates, irrelevante data en corrupte data er uit te halen.

<br>

### Archive scripts <a name="archive"></a>
3. Voer de [Create_Archive.sql](./scripts/ARCHIVE/Create_Archive.sql) script uit in SSMS. Deze script kopieert de structuur van de tabellen in de RAW-schema om de tabellen in de ARCHIVE-schema aan te maken. Alle records die duplicates, irrelevante data en corrupte data bevatten, komen hierin terecht.

<br>

## Datawarehouse <a name="dwh"></a>
In deze stap beginnen we aan de datawarehouse. Om de gezuiverde data vanuit SSIS inladen in SSMS moeten we eerst het nodige doen in SSMS en maken we daarna gebruik van SSIS.

### DWH setup in SSMS <a name="ssms"></a>
1. In de [Database setup](#databasesetup) hadden we de *VisionAirport_DWH* database aangemaakt. In deze database gaan we de gezuivere data inladen.
2. Voer de [Create_DWH_Tables.sql](./scripts/DWH/Create_DWH_Tables.sql) script uit in de *VisionAirport_DWH* database.
> Script bestaat nog niet. Enkel nog gedaan voor Vlucht.

### Data inladen in DWH met SSIS <a name="ssis"></a>
Om de solution probleemloos te kunnen uitvoeren moeten we eerst de connectie naar de juiste databases maken en dan de SSIS packages uitvoeren. 

#### Database connectie
Om de connectie naar de juiste databases te maken maken we gebruik van deze [solution](./introBI-visionAirport). Voer volgende stappen uit voor elke connectie (OLTP en DWH) in de *Connection Manager* folder:
1. Dubbelklik op de connectie om het beheer-scherm te openen.
2. Selecteer *Native OLE DB\SQL Server Native Client 11.0* als provider.
3. Bij Server name geef je de servernaam van je machine in. Dit is de Server name die je gebruikt om aan te melden bij SSMS.
>Let op: druk **niet** op het dropdown pijltje links van de Refresh button!
4. Laat voor de rest alle connectie instellingen zoals ze er staan en druk op *OK*.

#### SSIS-packages
Voer nu de SSIS packages uit in de gegeven volgorde:
>Nog afmaken en pushen

<br>

## Analyseren met PowerBI <a name="powerbi"></a>
Aan de hand van de data die ingeladen werd in het datawarehouse, maken we het dashboard.
<br>
