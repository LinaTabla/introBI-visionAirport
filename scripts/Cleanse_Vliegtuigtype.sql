use VisionAiport_OLTP;

INSERT INTO [CLEANSED].[vliegtuigtype]
	SELECT 
		CAST(IATA AS varchar(10)),
		NULLIF(CAST(ICAO AS varchar(10)), ''),
		NULLIF(CAST(Merk AS varchar(10)), ''),
		CAST(Type AS varchar(100)),
		NULLIF(CAST(Wake AS varchar(5)), ''),
		NULLIF(CAST(Cat AS varchar(20)), ''),
		NULLIF(CAST(Capaciteit AS int), ''),
		NULLIF(CAST(Vracht AS int), '')
	FROM [RAW].[export_vliegtuigtype];


