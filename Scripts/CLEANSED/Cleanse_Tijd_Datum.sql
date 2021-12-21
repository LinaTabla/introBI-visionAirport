USE [VisionAirport_OLTP];

-- Generate our own data.
DECLARE @StartDate  date = '20140101';
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 30, @StartDate));

-- SET LANGUAGE Dutch;
SET LANGUAGE us_english;

WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
),
dim AS
(
  SELECT
	DagNummer		=	TheDay,
	DagTekst		=	TheDayName,
	FiscaleWeek		=	CASE WHEN (TheWeek - 1) <= 0 THEN TheWeek + 52 ELSE TheWeek - 1 END,
	Maand			=	TheMonth,
	Jaar			=	TheYear,
	VolledigeDatum	=	TheDate
  FROM src
)
INSERT
	INTO [CLEANSED].[generatedDatum]
	SELECT * 
		FROM dim
		ORDER BY VolledigeDatum
		OPTION (MAXRECURSION 0)
GO

DECLARE @hour	int = 0;
DECLARE @minute int = 0;

WHILE @hour < 24
BEGIN
	SET @minute = 0;

	WHILE @minute < 60
	BEGIN
		INSERT INTO [CLEANSED].[generatedTime]
			SELECT
			(@hour*100) + @minute as TimeKey,
			@hour as [Hour],
			@minute as [Minute];

		SET @minute = @minute + 1;
	END;

	SET @hour = @hour + 1;
END
GO
