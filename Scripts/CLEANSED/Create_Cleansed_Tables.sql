USE [VisionAirport_OLTP];

-- Maatschappijen
DROP TABLE IF EXISTS [CLEANSED].[maatschappijen];
CREATE TABLE [CLEANSED].[maatschappijen]
(
	Name varchar(50)	NOT NULL	PRIMARY KEY,
	IATA varchar(10)	NULL,
	ICAO varchar(10)	NULL
);

--Vliegtuigtype
DROP TABLE IF EXISTS [CLEANSED].[vliegtuigtype];
CREATE TABLE [CLEANSED].[vliegtuigtype]
(
	IATA		char(3)		NOT NULL	PRIMARY KEY,
	ICAO		varchar(4)	NULL,
	Merk		varchar(50) NULL,
	Type		varchar(100) NULL,
	Wake		varchar(5)	NULL,
	Cat			varchar(20) NULL,
	Capaciteit	int			NULL,
	Vracht		int			NULL
);

-- Vliegtuig
DROP TABLE IF EXISTS [CLEANSED].[vliegtuig];
CREATE TABLE [CLEANSED].[vliegtuig]
(
	Vliegtuigcode	varchar(8)	NOT NULL	PRIMARY KEY,
	Airlinecode		char(5)		NULL,
	Vliegtuigtype	varchar(3)	NULL,
	Bouwjaar		int			NULL
);

-- Banen
DROP TABLE IF EXISTS [CLEANSED].[banen];
CREATE TABLE [CLEANSED].[banen]
(
	Baannummer	int			NOT NULL PRIMARY KEY,
	Code		varchar(7)	NULL,
	Naam		varchar(50) NULL,
	Lengte		int			NULL
);

-- Vertrek
DROP TABLE IF EXISTS [CLEANSED].[vertrek];
CREATE TABLE [CLEANSED].[vertrek]
(
	Vluchtid		int			NOT NULL PRIMARY KEY,
	Vliegtuigcode	varchar(10) NULL,
	Terminal		char(1)		NULL,
	Gate			char(2)		NULL,
	Baan			int			NULL,
	Bezetting		int			NULL,
	Vracht			int			NULL,
	Vertrektijd		datetime	NULL
);

-- Aankomst
DROP TABLE IF EXISTS [CLEANSED].[aankomst];
CREATE TABLE [CLEANSED].[aankomst]
(
	Vluchtid		int			NOT NULL	PRIMARY KEY,
	Vliegtuigcode	varchar(10) NULL,
	Terminal		char(1)		NULL,
	Gate			char(2)		NULL,
	Baan			int			NULL,
	Bezetting		int			NULL,
	Vracht			int			NULL,
	Aankomsttijd	datetime	NULL
);

-- Klant
DROP TABLE IF EXISTS [CLEANSED].[klant];
CREATE TABLE [CLEANSED].[klant]
(
	Vluchtid		int		NOT NULL	PRIMARY KEY,
	Operatie		float	NULL,
	Faciliteiten	float	NULL,
	Shops			float	NULL
)

-- Luchthavens
DROP TABLE IF EXISTS [CLEANSED].[luchthavens];
CREATE TABLE [CLEANSED].[luchthavens]
(
	Airportid	int				NOT NULL	PRIMARY KEY,
	Airport		varchar(100)	NULL,
	City		varchar(50)		NULL,
    Country		varchar(50)		NULL,
	IATA		char(3)			NULL,
	ICAO		char(4)			NULL,
	Lat			float			NULL,
	Lon			float			NULL,
	Alt			int				NULL,
	TZ			float			NULL,
	DS			char(1)			NULL,
	T_Z			varchar(50)		NULL
);

-- Planning
DROP TABLE IF EXISTS [CLEANSED].[planning];
CREATE TABLE [CLEANSED].[planning]
(
	Vluchtnr		varchar(8)	NOT NULL PRIMARY KEY,
	Airlinecode		varchar(3)	NOT NULL,
	Destcode		char(3)		NOT NULL,
	Planterminal	char(1)		NULL,
	Plangate		char(2)		NULL,
	Plantijd		time		NULL
);

-- Vlucht
DROP TABLE IF EXISTS [CLEANSED].[vlucht];
CREATE TABLE [CLEANSED].[vlucht]
(
	Vluchtid		int			NOT NULL	PRIMARY KEY,
	Vluchtnr		varchar(7)	NULL,
	Airlinecode		varchar(3)	NULL,
	Destcode		varchar(3)	NULL,
	Vliegtuigcode	varchar(8)	NULL,
	Datum			datetime	NULL
);

-- Weer
DROP TABLE IF EXISTS [CLEANSED].[weer];
CREATE TABLE [CLEANSED].[weer]
(
	Datum	date	NOT NULL	PRIMARY KEY,
	DDVEC	int		NULL,
	FHVEC	int		NULL,
	FG		int		NULL,
	FHX		int		NULL,
	FHXH	int		NULL,
	FHN		int		NULL,
	FHNH	int		NULL,
	FXX		int		NULL,
	FXXH	int		NULL,
	TG		int		NULL,
	TN		int		NULL,
	TNH		int		NULL,
	TX		int		NULL,
	TXH		int		NULL,
	T10N	int		NULL,
	T10NH	int		NULL,
	SQ		int		NULL,
	SP		int		NULL,
	Q		int		NULL,
	DR		int		NULL,
	RH		int		NULL,
	RHX		int		NULL,
	RHXH	int		NULL,
	PG		int		NULL,
	PX		int		NULL,
	PXH		int		NULL,
	PN		int		NULL,
	PNH		int		NULL,
	VVN		int		NULL,
	VVNH	int		NULL,
	VVX		int		NULL,
	VVXH	int		NULL,
	NG		int		NULL,
	UG		int		NULL,
	UX		int		NULL,
	UXH		int		NULL,
	UN		int		NULL,
	UNH		int		NULL,
	EV2		int		NULL
);
