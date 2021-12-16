use VisionAiport_OLTP;


INSERT INTO [CLEANSED].klant
	SELECT 
	CAST(Vluchtid AS int),
	CAST(Operatie AS decimal(18,2)),
	CAST(Faciliteiten AS decimal(18,2)),
	NULLIF(CAST(Shops AS decimal(18,2)), '')
	FROM [RAW].[export_klant]
	WHERE Shops IS NOT NULL;


select * from CLEANSED.klant;
