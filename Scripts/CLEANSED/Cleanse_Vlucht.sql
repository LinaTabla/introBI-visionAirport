USE [VisionAirport_OLTP];

INSERT INTO [CLEANSED].[vlucht]
	SELECT 
		CAST(VluchtId AS int),
		NULLIF(CAST(Vluchtnr AS varchar(7)), ''),
		NULLIF(CAST(AirlineCode AS varchar(3)), '-'),
		CAST(DestCode AS varchar(3)),
		CAST(Vliegtuigcode AS varchar(8)),
		CAST(Datum AS date)
	FROM [RAW].[export_vlucht];