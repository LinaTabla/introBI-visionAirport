use VisionAiport_OLTP;

INSERT INTO [CLEANSED].[vliegtuigtype]
	SELECT *
	FROM (
		SELECT 
			NULLIF(CAST(IATA AS varchar(10)),'') IATA, 
			CAST(NULLIF(NULLIF(ICAO, ''), 'n/a') AS varchar(10)) ICAO, 
			NULLIF(CAST(Merk AS varchar(10)),'') Merk,
			NULLIF(CAST(Type AS varchar(100)),'') Type,
			CAST(NULLIF(NULLIF(WAKE, ''), 'n/a') AS varchar(5)) Wake,
			NULLIF(CAST(CAT AS varchar(50)), '') Cat,
			CAST(NULLIF(Capaciteit, '') AS int) Capaciteit,
			CAST(NULLIF(Vracht, '') AS int)  Vracht
		FROM [RAW].[export_vliegtuigtype]
	) AS [vliegtuigtype]
	WHERE Merk IS NOT NULL;

