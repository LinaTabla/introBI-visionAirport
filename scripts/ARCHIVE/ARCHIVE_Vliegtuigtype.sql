
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
