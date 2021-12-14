# Vision Airport project for Intro BI

<br>

# Handleiding
Dit project bestaat uit vijf grote stappen:
1. [Data importing](#raw)
2. [Data cleaning](#cleansed)
3. [Data Warehouse](#dwh)
4. [Data inladen in DWH met SSIS](#ssis)
5. [Analyseren met PowerBI](#powerbi)

<br>

## Data importing <a name="raw"></a>
Import RAW data in SQL Server Management Studio.
>See **Database_Setup.sql** in *scripts* file

## Data cleaning <a name="cleansed"></a>
Drie schema's maken in de VisionAirport_OLTP database:
- RAW: de één op één ingeladen data in SSMS
- ARCHIVED: dirty data van RAW schema in deze schema steken
- CLEANSED: alle data van de RAW schema min de data van de ARCHIVED schema

## Data Warehouse creatie scripts <a name="dwh"></a>
In SSMS de juiste dataypes en relaties leggen (PK, FK, ...)

### 1. Create cleansed tables
Maak alle CLEANSED-tabellen aan met de juiste datatypes en PK's.
>Zie **Create_Cleansed_Tables.sql** script

### 2. Insert cleansed tables
Vul de CLEANSED-tabellen met data van de RAW-tabellen.
>Zie **Cleanse_*.sql** scripts

### 3. Leg FK's, verwijder duplicates, ...
(TO DO)

## Data inladen in DWH met SSIS <a name="ssis"></a>
Eerst Full Load, dan Incremental Load.

## Analyseren met PowerBI <a name="powerbi"></a>
Aan de hand van de data die ingeladen werd in het datawarehouse, maken we het dashboard.
