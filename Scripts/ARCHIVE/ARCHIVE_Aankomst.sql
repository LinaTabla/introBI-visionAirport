INSERT INTO [ARCHIVE].[aankomst] 
    SELECT 
        CAST(CAST(REPLACE(A.VluchtId, ',', '.') AS float) AS int), 
        CAST(A.VliegtuigCode AS varchar(10)), 
        CAST(Terminal AS char(1)), 
        NULLIF(CAST(Gate AS char(2)),''), 
        CAST(Baan AS int), 
        CAST(Bezetting AS int), 
        CAST(Vracht AS int), 
        CAST(AankomstTijd AS datetime) AankomstTijd
    FROM [RAW].[export_aankomst] A
        LEFT OUTER JOIN [CLEANSED].[vlucht] V
            ON V.VluchtId = CAST(CAST(REPLACE(A.VluchtId, ',', '.') AS float) AS bigint)
    WHERE Aankomsttijd = '' OR V.VluchtId IS NULL;
