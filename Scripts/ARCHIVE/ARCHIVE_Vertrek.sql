INSERT INTO [ARCHIVE].[vertrek]
	SELECT 
		CAST(CAST(REPLACE(Vluchtid, ',', '.') AS float) AS int),
		CAST(VliegtuigCode AS varchar(10)), 
		NULLIF(CAST(Terminal AS varchar(10)), ''), 
		NULLIF(CAST(Gate AS varchar(10)), ''), 
		NULLIF(CAST(Baan AS int), ''), 
		NULLIF(CAST(Bezetting AS int), ''), 
		NULLIF(CAST(Vracht AS varchar(10)), ''), 
		NULLIF(CAST(Aankomsttijd AS datetime), '')
	FROM [RAW].[export_vertrek]
	WHERE NULLIF(CAST(Vertrektijd AS DATETIME), '') IS NULL;
