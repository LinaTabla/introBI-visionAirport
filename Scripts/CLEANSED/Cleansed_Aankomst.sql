USE [VisionAirport_OLTP];

INSERT INTO [CLEANSED].[vertrek]
	SELECT 
		CAST(CAST(REPLACE(VluchtId, ',', '.') AS float) AS int),
		CAST(VliegtuigCode AS varchar(10)), 
		NULLIF(CAST(Terminal AS char(1)), ''), 
		NULLIF(CAST(Gate AS char(2)), ''), 
		NULLIF(CAST(Baan AS int), ''), 
		NULLIF(CAST(Bezetting AS int), ''), 
		NULLIF(CAST(Vracht AS int), ''), 
		NULLIF(CAST(Vertrektijd AS datetime), '')			
	FROM [RAW].[export_vertrek]
	WHERE NULLIF(CAST(Vertrektijd AS datetime), '') IS NOT NULL;