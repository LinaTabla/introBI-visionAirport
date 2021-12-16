USE [VisionAirport_OLTP];

INSERT INTO [CLEANSED].[vliegtuig]
	SELECT 
		NULLIF(CAST(VliegtuigCode AS varchar(8)), ''),
		NULLIF(CAST(VliegtuigType AS char(3)), ''),
		NULLIF(CAST(AirlineCode AS varchar(5)), '-'),		
		NULLIF(CAST(Bouwjaar AS int), '')
	FROM [RAW].[export_vliegtuig];
