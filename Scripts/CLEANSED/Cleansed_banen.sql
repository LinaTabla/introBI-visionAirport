USE [VisionAirport_OLTP];

INSERT INTO [CLEANSED].[banen]
	SELECT 
		CAST(Baannummer AS int),
		CAST(Code AS varchar(7)),
		CAST(Naam AS varchar(50)),
		CAST(Lengte AS int)
	FROM [RAW].[export_banen];