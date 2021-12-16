USE [VisionAirport_OLTP];

INSERT INTO [CLEANSED].[klant]
	SELECT 
		CAST(Vluchtid AS int),
		CAST(Operatie AS float),
		CAST(Faciliteiten AS float),
		NULLIF(CAST(Shops AS float), 0)
	FROM [RAW].[export_klant]