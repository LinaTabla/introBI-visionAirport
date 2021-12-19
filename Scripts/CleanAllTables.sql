USE [VisionAirport_OLTP];

--Refresh database
DROP TABLE IF EXISTS [CLEANSED].[maatschappijen];
DROP TABLE IF EXISTS [CLEANSED].[vliegtuig];
DROP TABLE IF EXISTS [CLEANSED].[vliegtuigtype];
DROP TABLE IF EXISTS [CLEANSED].[aankomst];
DROP TABLE IF EXISTS [CLEANSED].[vertrek];
DROP TABLE IF EXISTS [CLEANSED].[banen];
DROP TABLE IF EXISTS [CLEANSED].[Klant];
DROP TABLE IF EXISTS [CLEANSED].[vlucht];
DROP TABLE IF EXISTS [CLEANSED].[Luchthavens];
DROP TABLE IF EXISTS [CLEANSED].[Planning];
DROP TABLE IF EXISTS [CLEANSED].[Weer];

DROP TABLE IF EXISTS [ARCHIVE].[maatschappijen];
DROP TABLE IF EXISTS [ARCHIVE].[vliegtuigtype];
DROP TABLE IF EXISTS ARCHIVE.aankomst;
DROP TABLE IF EXISTS ARCHIVE.vliegtuig;
DROP TABLE IF EXISTS ARCHIVE.banen;
DROP TABLE IF EXISTS ARCHIVE.vlucht;
DROP TABLE IF EXISTS [ARCHIVE].[vertrek];
DROP TABLE IF EXISTS [ARCHIVE].[Klant];
DROP TABLE IF EXISTS [ARCHIVE].[Luchthavens];
DROP TABLE IF EXISTS [ARCHIVE].[Planning];
DROP TABLE IF EXISTS [ARCHIVE].[Weer];


-- Maatschappijen
SELECT TOP 0 * INTO [ARCHIVE].[maatschappijen] FROM [RAW].[export_maatschappijen];

CREATE TABLE [CLEANSED].[maatschappijen]
(
	MaatschappijId	int	NOT NULL	IDENTITY	PRIMARY KEY,
	Naam	varchar(50)	NOT NULL,
	IATA	varchar(2)	NULL,
	ICAO	varchar(4)	NULL
);

-- Fill Archived table
INSERT INTO [ARCHIVE].[maatschappijen]
	SELECT *
	FROM (
		SELECT 
			REPLACE(CAST(Name AS varchar(50)), '\', '') Name,
			NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CAST(IATA AS varchar(10)), '?', ''), '+', ''), ';', ''), '"', ''), '^', ''), '-', ''), '\N', ''), '') IATA, 
			NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(CAST(ICAO AS varchar(10)), '+', ''), '-', ''), 'N/A', ''), '\N', ''), '') ICAO 
		FROM [RAW].[export_maatschappijen]
	) AS maatschappijen
	WHERE IATA IS NULL
		OR Name = 'China Airlines Cargo'
		OR Name = 'Cathay Pacific Cargo'
		OR Name = 'Iran Air Cargo'
		OR Name = 'Japan Airlines Domestic'
		OR Name = 'Korean Air Cargo'
		OR Name = 'MASkargo'
		OR Name = 'Qatar Airways Cargo'
		OR Name = 'Royal Nepal Airlines'
		OR Name = 'Tiger Airways Australia'
		OR Name = 'Turkish Airlines Cargo'
		OR Name = 'Emirates SkyCargo';

-- Fill Cleansed table 
INSERT INTO [CLEANSED].[maatschappijen]
	SELECT *
	FROM (
		SELECT 
			REPLACE(CAST(Name AS varchar(50)), '\', '') Name,
			NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CAST(IATA AS varchar(10)), '?', ''), '+', ''), ';', ''), '"', ''), '^', ''), '-', ''), '\N', ''), '') IATA, 
			NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(CAST(ICAO AS varchar(10)), '+', ''), '-', ''), 'N/A', ''), '\N', ''), '') ICAO 
		FROM [RAW].[export_maatschappijen]
	) AS [export_maatschappijen]
	WHERE IATA IS NOT NULL
		AND Name <> 'China Airlines Cargo'
		AND Name <> 'Cathay Pacific Cargo'
		AND Name <> 'Iran Air Cargo'
		AND Name <> 'Japan Airlines Domestic'
		AND Name <> 'Korean Air Cargo'
		AND Name <> 'MASkargo'
		AND Name <> 'Qatar Airways Cargo'
		AND Name <> 'Royal Nepal Airlines'
		AND Name <> 'Tiger Airways Australia'
		AND Name <> 'Turkish Airlines Cargo'
		AND Name <> 'Emirates SkyCargo'
		AND Name <> 'Emirates SkyCargo';

 -- Vliegtuigtype
select top 0 * into ARCHIVE.vliegtuigtype from [RAW].[export_vliegtuigtype];

CREATE TABLE [CLEANSED].[vliegtuigtype]
(
    IATA    char(3)    NOT NULL    PRIMARY KEY,
    ICAO    varchar(4)    NULL,
    Merk    varchar(50)    NULL,
    Type    varchar(100)    NULL,
    Wake    varchar(5)    NULL,
    Cat    varchar(20)    NULL,
    Capaciteit    int    NULL,
    Vracht    int    NULL
);

-- Insert data into tables
INSERT INTO [ARCHIVE].[vliegtuigtype]
    SELECT *
    FROM (
        SELECT 
            NULLIF(CAST(IATA AS varchar(10)),'') IATA, 
            CAST(NULLIF(NULLIF(ICAO, ''), 'n/a') AS varchar(10)) ICAO, -- check on two expressions
            NULLIF(CAST(Merk AS varchar(50)),'') Merk,
            NULLIF(CAST(Type AS varchar(100)),'') [Type],
            CAST(NULLIF(NULLIF(WAKE, ''), 'n/a') AS varchar(5)) Wake, -- check on two expressions
            NULLIF(CAST(CAT AS varchar(50)), '') Cat,
            CAST(NULLIF(Capaciteit, '') AS int) Capaciteit,
            CAST(NULLIF(Vracht, '') AS int) Vracht
        FROM [RAW].[export_vliegtuigtype]
    ) AS [vliegtuigtype]
    WHERE Merk IS NULL;

INSERT INTO [CLEANSED].[vliegtuigtype]
    SELECT *
    FROM (
        SELECT 
            NULLIF(CAST(IATA AS char(3)),'') IATA, 
            CAST(NULLIF(NULLIF(ICAO, ''), 'n/a') AS varchar(4)) ICAO, 
            NULLIF(CAST(Merk AS varchar(50)),'') Merk,
            NULLIF(CAST(Type AS varchar(100)),'') Type,
            CAST(NULLIF(NULLIF(Wake, ''), 'n/a') AS varchar(5)) Wake,
            NULLIF(CAST(Cat AS varchar(20)), '') Cat,
            CAST(NULLIF(Capaciteit, '') AS int) Capaciteit,
            CAST(NULLIF(Vracht, '') AS int) Vracht
        FROM [RAW].[export_vliegtuigtype]
    ) AS [vliegtuigtype]
    WHERE Merk IS NOT NULL;

-- Vliegtuig
SELECT TOP 0 * INTO ARCHIVE.vliegtuig FROM RAW.export_vliegtuig;

CREATE TABLE [CLEANSED].[vliegtuig]
(
	VliegtuigCode	varchar(8)	NOT NULL	PRIMARY KEY,
	VliegtuigType	char(3)	NOT NULL,
	AirlineCode	varchar(5)	NULL,
	Bouwjaar	int	NULL,
	FOREIGN KEY (VliegtuigType) REFERENCES [CLEANSED].[vliegtuigtype](IATA)
);

INSERT INTO [CLEANSED].[vliegtuig]
	SELECT 
		NULLIF(CAST(VliegtuigCode AS varchar(8)), ''),
		NULLIF(CAST(VliegtuigType AS char(3)), ''),
		NULLIF(CAST(AirlineCode AS varchar(5)), '-'),		
		NULLIF(CAST(Bouwjaar AS int), '')
	FROM [RAW].[export_vliegtuig];

-- Vlucht
SELECT TOP 0 * INTO ARCHIVE.vlucht FROM RAW.export_vlucht;

CREATE TABLE [CLEANSED].[vlucht]
(
	VluchtId	int	NOT NULL	PRIMARY KEY,
	Vluchtnr	varchar(7)	NULL,
	Airlinecode	varchar(3)	NULL,
	Destcode	varchar(3)	NULL,
	Vliegtuigcode	varchar(8)	NULL,
	Datum	datetime	NULL
);

INSERT INTO ARCHIVE.[vlucht]
	SELECT 
		CAST(VluchtId AS int),
		NULLIF(CAST(VluchtNr AS varchar(7)), ''),
		NULLIF(CAST(AirlineCode AS varchar(3)), '-'),	-- dash used instead of null
		NULLIF(CAST(DestCode AS varchar(3)), ''),
		NULLIF(CAST(Vliegtuigcode AS varchar(8)), ''),
		NULLIF(CAST(Datum AS date), '')
	FROM [RAW].[export_vlucht]
	where 
		Vluchtid IS NULL
		OR Vluchtnr IS NULL 
		OR Airlinecode IS NULL
		OR Destcode IS NULL
		OR Vliegtuigcode IS NULL
		OR Datum IS NULL;

INSERT INTO [CLEANSED].[vlucht]
	SELECT 
		CAST(VluchtId AS int),
		NULLIF(CAST(Vluchtnr AS varchar(7)), ''),
		NULLIF(CAST(AirlineCode AS varchar(3)), '-'),
		CAST(DestCode AS varchar(3)),
		CAST(Vliegtuigcode AS varchar(8)),
		CAST(Datum AS date)
	FROM [RAW].[export_vlucht];

-- Banen
select top 0 * into ARCHIVE.banen from RAW.export_banen;

CREATE TABLE [CLEANSED].[banen]
(
	Baannummer	int	NOT NULL	PRIMARY KEY,
	Code	varchar(7)	NULL,
	Naam	varchar(50)	NULL,
	Lengte	int	NULL
);

INSERT INTO [CLEANSED].[banen]
	SELECT 
		CAST(Baannummer AS int),
		CAST(Code AS varchar(7)),
		CAST(Naam AS varchar(50)),
		CAST(Lengte AS int)
	FROM [RAW].[export_banen];

-- Aankomst
select top 0 * into ARCHIVE.aankomst from RAW.export_aankomst;

CREATE TABLE [CLEANSED].[aankomst]
(
	VluchtId	int	NOT NULL	PRIMARY KEY,
	VliegtuigCode	varchar(10)	NULL,
	Terminal	char(1)	NULL,
	Gate	char(2)	NULL,
	Baan	int	NULL,
	Bezetting	int	NULL,
	Vracht	int	NULL,
	Aankomsttijd	datetime	NULL,
	FOREIGN KEY (VluchtId) REFERENCES [CLEANSED].[vlucht](VluchtId),
	FOREIGN KEY (Baan) REFERENCES [CLEANSED].[banen](Baannummer)
);

INSERT INTO [ARCHIVE].[aankomst] 
    SELECT 
        CAST(CAST(REPLACE(A.VluchtId, ',', '.') AS float) AS int), 
        CAST(A.VliegtuigCode AS varchar(10)), 
        CAST(Terminal AS char(1)), 
        NULLIF(CAST(Gate AS char(2)),''), 
        CAST(Baan AS int), 
        CAST(Bezetting AS int), 
        CAST(Vracht AS int), 
        CAST(AankomstTijd AS datetime) AankomstTijd
    FROM [RAW].[export_aankomst] A
        LEFT OUTER JOIN [CLEANSED].[vlucht] V
            ON V.VluchtId = CAST(CAST(REPLACE(A.VluchtId, ',', '.') AS float) AS bigint)
    WHERE Aankomsttijd = '' OR V.VluchtId IS NULL;

INSERT INTO [CLEANSED].[aankomst] 
	SELECT 
		CAST(CAST(REPLACE(A.VluchtId, ',', '.') AS float) AS int),
		CAST(A.VliegtuigCode AS varchar(10)), 
		NULLIF(CAST(Terminal AS char(1)), ''), 
		NULLIF(CAST(Gate AS char(2)), ''), 
		NULLIF(CAST(Baan AS int), ''), 
		NULLIF(CAST(Bezetting AS int), ''), 
		NULLIF(CAST(Vracht AS int), ''),
		NULLIF(CAST(Aankomsttijd AS datetime), '')
	FROM [RAW].[export_aankomst] A
		LEFT OUTER JOIN [CLEANSED].[vlucht] V
			ON V.VluchtId = CAST(CAST(REPLACE(A.VluchtId, ',', '.') AS float) AS int)
	WHERE Aankomsttijd <> '' AND V.VluchtId IS NOT NULL;

-- Vertrek
select top 0 * into ARCHIVE.vertrek from RAW.export_vertrek;

CREATE TABLE [CLEANSED].[vertrek]
(
	VluchtId	int	NOT NULL	PRIMARY KEY,
	Vliegtuigcode	varchar(10)	NULL,
	Terminal	char(1)	NULL,
	Gate	char(2)	NULL,
	Baan	int NULL,
	Bezetting	int	NULL,
	Vracht	int	NULL,
	Vertrektijd	datetime	NULL,
	FOREIGN KEY (VluchtId) REFERENCES [CLEANSED].[vlucht](VluchtId),
	FOREIGN KEY (Baan) REFERENCES [CLEANSED].[banen](Baannummer)
);

	-- Insert data into tables
	INSERT INTO [ARCHIVE].[vertrek]
	SELECT 
		CAST(CAST(REPLACE(Vluchtid, ',', '.') AS float) AS int),
		CAST(VliegtuigCode AS varchar(10)), 
		NULLIF(CAST(Terminal AS varchar(10)), ''), 
		NULLIF(CAST(Gate AS varchar(10)), ''), 
		NULLIF(CAST(Baan AS int), ''), 
		NULLIF(CAST(Bezetting AS int), ''), 
		NULLIF(CAST(Vracht AS varchar(10)), ''), 
		NULLIF(CAST(Vertrektijd AS datetime), '')
	FROM [RAW].[export_vertrek]
	WHERE NULLIF(CAST(Vertrektijd AS DATETIME), '') IS NULL;

	INSERT INTO [CLEANSED].[vertrek]
	SELECT 
		CAST(CAST(REPLACE(VluchtId, ',', '.') AS float) AS int),
		CAST(VliegtuigCode AS varchar(10)), 
		NULLIF(CAST(Terminal AS char(1)), ''), 
		NULLIF(CAST(Gate AS char(2)), ''), 
		NULLIF(CAST(Baan AS int), ''), 
		NULLIF(CAST(Bezetting AS int), ''), 
		NULLIF(CAST(Vracht AS int), ''), 
		NULLIF(CAST(Vertrektijd AS datetime), '')			
	FROM [RAW].[export_vertrek]
	WHERE NULLIF(CAST(Vertrektijd AS datetime), '') IS NOT NULL;

-- Klant
select top 0 * into ARCHIVE.klant from RAW.export_klant;

CREATE TABLE [CLEANSED].[klant]
(
	VluchtId	int	NOT NULL	PRIMARY KEY,
	Operatie	float	NULL,
	Faciliteiten	float	NULL,
	Shops	float	NULL,
	FOREIGN KEY (VluchtId) REFERENCES [CLEANSED].[vlucht](VluchtId)
)

	-- Insert data into tables
	INSERT INTO [CLEANSED].[klant]
	SELECT 
		CAST(Vluchtid AS int),
		CAST(Operatie AS float),
		CAST(Faciliteiten AS float),
		NULLIF(CAST(Shops AS float), 0)
	FROM [RAW].[export_klant]

-- Luchthavens
select top 0 * into ARCHIVE.luchthavens from [RAW].[export_luchthavens];

CREATE TABLE [CLEANSED].[luchthavens]
(
	LuchthavenId	int	NOT NULL	IDENTITY	PRIMARY KEY,
	Naam	varchar(100)	NULL,
	Stad	varchar(50)	NULL,
    Land	varchar(50)	NULL,
	IATA	char(3)	NULL,
	ICAO	char(4)	NULL,
	Latitude	float	NULL,
	Longitude	float	NULL,
	Altitude	int	NULL,
	TZ	float	NULL,
	DST	char(1)	NULL,
	Area	varchar(100)	NULL
);

	-- Insert data into tables
	INSERT INTO [ARCHIVE].[luchthavens]
	SELECT *	
	FROM (
		SELECT 
			CAST(Airport AS varchar(100)) Naam,
			CAST(City AS varchar(50)) Stad,
			CAST(Country AS varchar(40)) Land,
			NULLIF(CAST(IATA AS varchar(10)), '') IATA,
			NULLIF(REPLACE(CAST(ICAO AS varchar(10)), '\N', ''), '') ICAO,
			CAST(Lat AS float) Latitude,
			CAST(Lon AS float) Longitude,
			CAST(Alt AS int) Altidue,
			CAST(TZ AS float) TimeZoneNummer,
			CAST(DST AS char(3)) DST,
			NULLIF(REPLACE(CAST(Tz2 AS varchar(50)), '\N', ''), '') TimeZoneTekst
		FROM [RAW].[export_luchthavens]
	) AS export_luchthavens
	WHERE ICAO IS NULL;

	INSERT INTO [CLEANSED].[luchthavens]
	SELECT *	
	FROM (
		SELECT
			CAST(Airport AS varchar(100)) Naam,
			CAST(City AS varchar(50)) Stad,
			CAST(Country AS varchar(50)) Land,
			NULLIF(CAST(IATA AS char(3)), '') IATA,
			NULLIF(REPLACE(CAST(ICAO AS char(4)), '\N', ''), '') ICAO,
			CAST(Lat AS float) Latitude,
			CAST(Lon AS float) Longitude,
			CAST(Alt AS int) Altidue,
			CAST(TZ AS float) TZ,
			CAST(DST AS char(1)) DST,
			NULLIF(REPLACE(CAST(Tz2 AS varchar(100)), '\N', ''), '') Area
		FROM [RAW].[export_luchthavens]
	) AS export_luchthavens
	WHERE ICAO IS NOT NULL

-- Planning
select top 0 * into ARCHIVE.planning from [RAW].[export_planning];

DROP TABLE IF EXISTS [CLEANSED].[planning];
CREATE TABLE [CLEANSED].[planning]
(
	Vluchtnr	varchar(8)	NOT NULL	PRIMARY KEY,
	Airlinecode	varchar(3)	NOT NULL,
	Destcode	char(3)	NOT NULL,
	Planterminal	char(1)	NULL,
	Plangate	char(2)	NULL,
	Plantijd	time	NULL
);

	-- Insert data into tables
	INSERT INTO [CLEANSED].[planning]
	SELECT 
		CAST(Vluchtnr AS varchar(8)) Vluchtnr,
		CAST(Airlinecode AS varchar(3)) Airlinecode,
		CAST(Destcode AS char(3)) Destcode,
		NULLIF(CAST(Planterminal AS char(1)), '') Planterminal,
		NULLIF(CAST(Plangate AS char(2)), '') Plangate,
		NULLIF(CAST(Plantijd AS time), '') Plantijd
	FROM [RAW].[export_planning];

-- Planterminal, Plangate, Plantijd -> mag op NULL staan

-- Weer
	select top 0 * into ARCHIVE.weer from [RAW].[export_weer];

	CREATE TABLE [CLEANSED].[weer]
	(
		Datum	datetime	NOT NULL	PRIMARY KEY,
		DDVEC	int	NULL,
		FHVEC	int	NULL,
		FG	int	NULL,
		FHX	int	NULL,
		FHXH	int	NULL,
		FHN	int	NULL,
		FHNH	int	NULL,
		FXX	int	NULL,
		FXXH	int	NULL,
		TG	int	NULL,
		TN	int	NULL,
		TNH	int	NULL,
		TX	int	NULL,
		TXH	int	NULL,
		T10N	int	NULL,
		T10NH	int	NULL,
		SQ	int	NULL,
		SP	int	NULL,
		Q	int	NULL,
		DR	int	NULL,
		RH	int	NULL,
		RHX	int	NULL,
		RHXH	int	NULL,
		PG	int	NULL,
		PX	int	NULL,
		PXH	int	NULL,
		PN	int	NULL,
		PNH	int	NULL,
		VVN	int	NULL,
		VVNH	int	NULL,
		VVX	int	NULL,
		VVXH	int	NULL,
		NG	int	NULL,
		UG	int	NULL,
		UX	int	NULL,
		UXH	int	NULL,
		UN	int	NULL,
		UNH	int	NULL,
		EV2	int	NULL
	);

	-- Insert data into tables
	INSERT INTO [CLEANSED].[weer]
	SELECT 
		CAST(Datum AS datetime),
		CAST(DDVEC AS int), 
		CAST(FHVEC AS int), 
		CAST(FG AS int), 
		CAST(FHX AS int), 
		CAST(FHXH AS int), 
		CAST(FHN AS int), 
		CAST(FHNH AS int), 
		CAST(FXX AS int), 
		CAST(FXXH AS int), 
		CAST(TG AS int),
		CAST(TN AS int),
		CAST(TNH AS int),
		CAST(TX AS int),
		CAST(TXH AS int),
		CAST(T10N AS int),
		CAST(T10NH AS int),
		CAST(SQ AS int),
		CAST(SP AS int),
		CAST(Q AS int),
		CAST(DR AS int),
		CAST(RH AS int),
		CAST(RHX AS int),
		CAST(RHXH AS int),
		CAST(PG AS int),
		CAST(PX AS int),
		CAST(PXH AS int),
		CAST(PN AS int),
		CAST(PNH AS int),
		CAST(VVN AS int),
		CAST(VVNH AS int),
		CAST(VVX AS int),
		CAST(VVXH AS int),
		CAST(NG AS int),
		CAST(UG AS int),
		CAST(UX AS int),
		CAST(UXH AS int),
		CAST(UN AS int),
		CAST(UNH AS int),
		CAST(EV2 AS int)
	FROM [RAW].[export_weer];