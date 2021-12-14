USE [VisionAirport_OLTP]
GO

DROP TABLE IF EXISTS [CLEANSED].[vlucht];

-- 1. Create cleansed table
CREATE TABLE [CLEANSED].[vlucht]
(
	Vluchtid		int			NOT NULL  PRIMARY KEY,
	Vluchtnr		varchar(7)	NULL,
	Airlinecode		varchar(3)	NULL,
	Destcode		varchar(3)	NULL,
	Vliegtuigcode	varchar(10)	NULL,
	Datum			date		NULL
);

-- 2. Insert data from RAW to CLEANSED (correct datatypes)
INSERT INTO [CLEANSED].[vlucht]
	SELECT 
		CAST(VluchtId AS int),
		NULLIF(CAST(VluchtNr AS varchar(7)), ''),
		NULLIF(CAST(AirlineCode AS varchar(3)), '-'),	-- dash used instead of null
		NULLIF(CAST(DestCode AS varchar(3)), ''),
		NULLIF(CAST(Vliegtuigcode AS varchar(8)), ''),
		NULLIF(CAST(Datum AS date), '')
	FROM [RAW].[export_vlucht];


-- 4. Create VisionAirport_DWH db


-- 3. Transfer vlucht table from VisionAirport_OLTP to VisionAirport_DWH
	-- 1. Right click table CLEANSED.vlucht > Script Table as > CREATE To > New Query Editor Window > Copy the generated code 
	-- 2. Right click db VisionAirport_DWH > New Query > Paste the copied code in this window 
	-- 3. Remove everything before the CREATE statement
	-- 4. Replace [CLEANSED].[vlucht] with [dbo].[vlucht]
	-- 5. Run the query
CREATE TABLE [dbo].[vlucht](
	[Vluchtid] [int] NOT NULL,
	[Vluchtnr] [varchar](7) NULL,
	[Airlinecode] [varchar](3) NULL,
	[Destcode] [varchar](3) NULL,
	[Vliegtuigcode] [varchar](10) NULL,
	[Datum] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Vluchtid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- 4. Fill VisionAirport_DWH table with SSIS
	-- 1. Open VS > Create new Integration Services Project
	-- 2. Open Toolbox > Drag Data Flow Task in the Control Flow > Double click the Data Flow Task
	-- 3. Create a new Connection Manager
		-- 1. In the Solution Explorer > right click Connection Manager > New Connection Manager > select OLEDB as the type > Add...
		-- 2. Select New...
		-- 3. When adding a Server name > ! don't click on the dropdown arrow left from the Refresh button !
		-- 4. Server name > enter the your SQL Server credentials
		-- 5. Select or enter a database name > click dropdown arrow > choose VisionAirport_OLTP (= datasource)
		-- 6. Test connection and click OK
	-- 4. Open Toolbox > Other Sources > Drag OLE DB Source in the Control Flow > Double click the OLE DB Source
	-- 5. Name of the table or the view > [CLEANSED].[vlucht] > ! just for demo purposes bcs no foreign keys, joins, ... !
	-- 6. See further steps: Les 03 > min. 43