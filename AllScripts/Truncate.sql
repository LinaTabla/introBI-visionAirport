-- SQL Statements for SQL Task in SSIS
-- 1. insert connection to your dwh (die gaan we leegmaken voordat die geladen wordt)
-- 2. insert SQL statement (eerst testen in SSMS!) = truncate statement = snel, telt terug van 1 = reset van uw tabel
TRUNCATE TABLE [dbo].[vlucht];

-- 3. Insert TRUNCATE statement in SSIS > SQLStatement

-- 4. Om te vermijden dat bij elke start alles in de control flow tegelijk wordt uitgevoerd: add arrows in SSIS
