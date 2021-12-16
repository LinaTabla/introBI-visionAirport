INSERT INTO ARCHIVE.[vlucht]
	SELECT 
		CAST(VluchtId AS int),
		NULLIF(CAST(VluchtNr AS varchar(7)), ''),
		NULLIF(CAST(AirlineCode AS varchar(3)), '-'),	-- dash used instead of null
		NULLIF(CAST(DestCode AS varchar(3)), ''),
		NULLIF(CAST(Vliegtuigcode AS varchar(8)), ''),
		NULLIF(CAST(Datum AS date), '')
	FROM [RAW].[export_vlucht]
	where 
		Vluchtid IS NULL
		OR Vluchtnr IS NULL 
		OR Airlinecode IS NULL
		OR Destcode IS NULL
		OR Vliegtuigcode IS NULL
		OR Datum IS NULL;
