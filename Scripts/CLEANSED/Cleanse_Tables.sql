USE [VisionAirport_OLTP];

-- Maatschappijen
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
INSERT INTO [CLEANSED].[vliegtuig]
	SELECT 
		NULLIF(CAST(VliegtuigCode AS varchar(8)), ''),
		NULLIF(CAST(VliegtuigType AS char(3)), ''),
		NULLIF(CAST(AirlineCode AS varchar(5)), '-'),		
		NULLIF(CAST(Bouwjaar AS int), '')
	FROM [RAW].[export_vliegtuig];

-- Vlucht
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
INSERT INTO [CLEANSED].[banen]
	SELECT 
		CAST(Baannummer AS int),
		CAST(Code AS varchar(7)),
		CAST(Naam AS varchar(50)),
		CAST(Lengte AS int)
	FROM [RAW].[export_banen];

-- Aankomst
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

-- Vertrek
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

-- Klant
INSERT INTO [CLEANSED].[klant]
	SELECT 
		CAST(Vluchtid AS int),
		CAST(Operatie AS float),
		CAST(Faciliteiten AS float),
		NULLIF(CAST(Shops AS float), 0)
	FROM [RAW].[export_klant]

-- Luchthavens
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
			NULLIF(REPLACE(CAST(Tz1 AS varchar(100)), '\N', ''), '') Area
		FROM [RAW].[export_luchthavens]
	) AS export_luchthavens
	WHERE ICAO IS NOT NULL 

-- Planning
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