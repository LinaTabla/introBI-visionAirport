INSERT INTO [ARCHIVE].[maatschappijen]
	SELECT *
	FROM (
		SELECT 
			REPLACE(CAST(Name AS varchar(50)), '\', '') Name,
			NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CAST(IATA AS varchar(10)), '?', ''), '+', ''), ';', ''), '"', ''), '^', ''), '-', ''), '\N', ''), '') IATA, 
			NULLIF(REPLACE(REPLACE(REPLACE(REPLACE(CAST(ICAO AS varchar(10)), '+', ''), '-', ''), 'N/A', ''), '\N', ''), '') ICAO 
		FROM [RAW].[export_maatschappijen]
	) AS maatschappijen
	WHERE IATA IS NULL
		OR Name = 'China Airlines Cargo'
		OR Name = 'Cathay Pacific Cargo'
		OR Name = 'Iran Air Cargo'
		OR Name = 'Japan Airlines Domestic'
		OR Name = 'Korean Air Cargo'
		OR Name = 'MASkargo'
		OR Name = 'Qatar Airways Cargo'
		OR Name = 'Royal Nepal Airlines'
		OR Name = 'Tiger Airways Australia'
		OR Name = 'Turkish Airlines Cargo'
		OR Name = 'Emirates SkyCargo';
