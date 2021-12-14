use VisionAiport_OLTP;

INSERT INTO [CLEANSED].maatschappijen
	SELECT 
	CAST(Name as varchar(50)), 
	NULLIF(CAST(IATA AS varchar(10)), ''),
	NULLIF(CAST(ICAO AS varchar(10)), '')
	FROM [RAW].[export_maatschappijen];

	select * from cleansed.maatschappijen