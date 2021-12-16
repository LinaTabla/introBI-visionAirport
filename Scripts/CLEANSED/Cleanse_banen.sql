use VisionAiport_OLTP;


INSERT INTO [CLEANSED].banen
	SELECT 
	CAST(Baannummer AS int),
	CAST(Code AS varchar(10)),
CAST(Naam AS varchar(100)),
CAST(Lengte AS int)
	FROM [RAW].[export_banen];

select * from raw.export_banen;