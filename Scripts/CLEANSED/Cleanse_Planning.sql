USE [VisionAirport_OLTP];

INSERT INTO [CLEANSED].[planning]
	SELECT 
		CAST(Vluchtnr AS varchar(8)) Vluchtnr,
		CAST(Airlinecode AS varchar(3)) Airlinecode,
		CAST(Destcode AS char(3)) Destcode,
		NULLIF(CAST(Planterminal AS char(1)), '') Planterminal,
		NULLIF(CAST(Plangate AS char(2)), '') Plangate,
		NULLIF(CAST(Plantijd AS time), '') Plantijd
	FROM [RAW].[export_planning];

-- Planterminal, Plangate, Plantijd -> mag op NULL staan
