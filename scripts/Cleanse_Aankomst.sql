use VisionAiport_OLTP;


INSERT INTO [CLEANSED].aankomst
	SELECT 
	NULLIF(CAST(Vluchtid AS int), ''), --Check this out!
	NULLIF(CAST(Vliegtuigcode AS varchar(10)), ''),
	NULLIF(CAST(Terminal AS varchar(10)), ''),
	NULLIF(CAST(Gate AS varchar(10)), ''),
	NULLIF(CAST(Baan AS int), ''),
	NULLIF(CAST(Bezetting AS int), ''),
	NULLIF(CAST(Vracht AS varchar(10)), ''),
	NULLIF(CAST(Aankomsttijd AS datetime), '')
	FROM [RAW].[export_aankomst];

select * from raw.export_aankomst;