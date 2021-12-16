USE [VisionAirport_OLTP];

INSERT INTO [CLEANSED].[maatschappijen]
	SELECT *
	FROM (
		SELECT 
			REPLACE(CAST(Name AS varchar(50)), '\', '') Name,
			NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CAST(IATA AS varchar(10)), '?', ''), '+', ''), ';', ''), '"', ''), '^', ''), '-', ''), '\N', ''), '') IATA, 
			NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(CAST(ICAO AS varchar(10)), '+', ''), '-', ''), 'N/A', ''), '\N', ''), '') ICAO 
		FROM [RAW].[export_maatschappijen]
	) AS [export_maatschappijen]
	WHERE IATA IS NOT NULL
		AND Name <> 'China Airlines Cargo'
		AND Name <> 'Cathay Pacific Cargo'
		AND Name <> 'Iran Air Cargo'
		AND Name <> 'Japan Airlines Domestic'
		AND Name <> 'Korean Air Cargo'
		AND Name <> 'MASkargo'
		AND Name <> 'Qatar Airways Cargo'
		AND Name <> 'Royal Nepal Airlines'
		AND Name <> 'Tiger Airways Australia'
		AND Name <> 'Turkish Airlines Cargo'
		AND Name <> 'Emirates SkyCargo'
		AND Name <> 'Emirates SkyCargo';