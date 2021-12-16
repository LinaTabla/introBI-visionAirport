INSERT INTO [CLEANSED].[luchthavens]
	SELECT *	
	FROM (
		SELECT
			CAST(Airport AS varchar(100)) Naam,
			CAST(City AS varchar(50)) Stad,
			CAST(Country AS varchar(50)) Land,
			NULLIF(CAST(IATA AS char(3)), '') IATA,
			NULLIF(REPLACE(CAST(ICAO AS char(4)), '\N', ''), '') ICAO,
			CAST(Lat AS float) Latitude,
			CAST(Lon AS float) Longitude,
			CAST(Alt AS int) Altidue,
			CAST(TZ AS float) TZ,
			CAST(DST AS char(1)) DST,
			NULLIF(REPLACE(CAST(Tz1 AS varchar(100)), '\N', ''), '') Area
		FROM [RAW].[export_luchthavens]
	) AS export_luchthavens
	WHERE ICAO IS NOT NULL 
