INSERT INTO [CLEANSED].[luchthavens]
	SELECT *	
	FROM (
		SELECT 
			CAST(Airport AS varchar(100)) Naam,
			CAST(City AS varchar(50)) Stad,
			CAST(Country AS varchar(40)) Land,
			NULLIF(CAST(IATA AS varchar(10)), '') IATA,
			NULLIF(REPLACE(CAST(ICAO AS varchar(10)), '\N', ''), '') ICAO,
			CAST(Lat AS decimal(11, 9)) Latitude,
			CAST(Lon AS decimal(11, 9)) Longitude,
			CAST(Alt AS int) Altidue,
			CAST(TZ AS decimal(4, 3)) TZ,
			CAST(DST AS char(3)) DST,
			NULLIF(REPLACE(CAST(Tz1 AS varchar(50)), '\N', ''), '') Tz1


		FROM [RAW].[export_luchthavens]
	) AS luchthavens
	WHERE ICAO IS NOT NULL 
