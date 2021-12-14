use VisionAiport_OLTP;

INSERT INTO [CLEANSED].Planning
	SELECT 
		CAST(Vluchtnr AS varchar(10)),
		CAST(Airlinecode AS varchar(10)),
		CAST(Destcode AS varchar(10)),
		NULLIF(CAST(Planterminal AS varchar(10)), ''),
		NULLIF(CAST(Plangate AS varchar(10)), ''),
		NULLIF(CAST(Plantijd AS datetime), '')
	FROM [RAW].[export_planning];
