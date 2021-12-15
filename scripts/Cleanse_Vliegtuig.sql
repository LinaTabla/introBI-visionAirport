use VisionAiport_OLTP;

INSERT INTO [CLEANSED].[vliegtuig]
	SELECT 
		NULLIF(CAST(AirlineCode AS varchar(3)), '-'),	-- dash used instead of null		
		NULLIF(CAST(Vliegtuigcode AS varchar(8)), ''),
		NULLIF(CAST(Vliegtuigtype AS varchar(8)), ''),
		NULLIF(CAST(Bouwjaar AS int), '')
	FROM [RAW].[export_vliegtuig]
	WHERE Airlinecode IS NOT NULL;

select * from CLEANSED.[vliegtuig];
