use VisionAiport_OLTP;

INSERT INTO [CLEANSED].maatschappijen
	SELECT 
	CAST(Name as varchar(50)), 
	NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CAST(IATA AS varchar(2)), '?', ''), '+', ''), ';', ''), '"', ''), '^', ''), '-', ''), '\N', ''), '') IATA, 
        NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(CAST(ICAO AS varchar(3)), '+', ''), '-', ''), 'N/A', ''), '\N', ''), '') ICAO 
        FROM [RAW].[export_maatschappijen]
	WHERE IATA  NOT LIKE '%[&;?\^-+]%'
	OR ICAO  NOT LIKE '%[&;?\^-+]%'

	select * from cleansed.maatschappijen

/*
Bepaalde maatschappijen worden eruit gehaald omdat er een foreign key gelegd wordt naar primary keys die niet bestaan (zie: tabel vliegtuigtype)
*/
