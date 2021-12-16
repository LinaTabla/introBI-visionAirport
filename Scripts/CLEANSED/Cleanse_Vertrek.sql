USE [VisionAirport_OLTP];

INSERT INTO [CLEANSED].[aankomst] 
	SELECT 
		CAST(CAST(REPLACE(A.VluchtId, ',', '.') AS float) AS int),
		CAST(A.VliegtuigCode AS varchar(10)), 
		NULLIF(CAST(Terminal AS char(1)), ''), 
		NULLIF(CAST(Gate AS char(2)), ''), 
		NULLIF(CAST(Baan AS int), ''), 
		NULLIF(CAST(Bezetting AS int), ''), 
		NULLIF(CAST(Vracht AS int), ''),
		NULLIF(CAST(Aankomsttijd AS datetime), '')
	FROM [RAW].[export_aankomst] A
		LEFT OUTER JOIN [CLEANSED].[vlucht] V
			ON V.VluchtId = CAST(CAST(REPLACE(A.VluchtId, ',', '.') AS float) AS int)
	WHERE Aankomsttijd <> '' AND V.VluchtId IS NOT NULL;