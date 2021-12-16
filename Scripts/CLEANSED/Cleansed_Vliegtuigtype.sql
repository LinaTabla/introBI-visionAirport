USE [VisionAirport_OLTP];

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

