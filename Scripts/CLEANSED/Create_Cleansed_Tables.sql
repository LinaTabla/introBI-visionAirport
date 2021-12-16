USE [VisionAirport_OLTP];

-- Maatschappijen
DROP TABLE IF EXISTS [CLEANSED].[maatschappijen];
CREATE TABLE [CLEANSED].[maatschappijen]
(
	MaatschappijId	int	NOT NULL	IDENTITY	PRIMARY KEY,
	Naam	varchar(50)	NOT NULL,
	IATA	varchar(2)	NULL,
	ICAO	varchar(4)	NULL
);

--Vliegtuigtype
DROP TABLE IF EXISTS [CLEANSED].[vliegtuigtype];
CREATE TABLE [CLEANSED].[vliegtuigtype]
(
	IATA	char(3)	NOT NULL	PRIMARY KEY,
	ICAO	varchar(4)	NULL,
	Merk	varchar(50)	NULL,
	Type	varchar(100)	NULL,
	Wake	varchar(5)	NULL,
	Cat	varchar(20)	NULL,
	Capaciteit	int	NULL,
	Vracht	int	NULL
);

-- Vliegtuig
DROP TABLE IF EXISTS [CLEANSED].[vliegtuig];
CREATE TABLE [CLEANSED].[vliegtuig]
(
	VliegtuigCode	varchar(8)	NOT NULL	PRIMARY KEY,
	AirlineCode	varchar(5)	NULL,
	VliegtuigType	char(3)	NOT NULL,
	Bouwjaar	int	NULL,
	FOREIGN KEY (VliegtuigType) REFERENCES [CLEANSED].[vliegtuigtype](IATA)
);

-- Vlucht
DROP TABLE IF EXISTS [CLEANSED].[vlucht];
CREATE TABLE [CLEANSED].[vlucht]
(
	VluchtId	int	NOT NULL	PRIMARY KEY,
	Vluchtnr	varchar(7)	NULL,
	Airlinecode	varchar(3)	NULL,
	Destcode	varchar(3)	NULL,
	Vliegtuigcode	varchar(8)	NULL,
	Datum	datetime	NULL
);

-- Banen
DROP TABLE IF EXISTS [CLEANSED].[banen];
CREATE TABLE [CLEANSED].[banen]
(
	Baannummer	int	NOT NULL	PRIMARY KEY,
	Code	varchar(7)	NULL,
	Naam	varchar(50)	NULL,
	Lengte	int	NULL
);

-- Aankomst
DROP TABLE IF EXISTS [CLEANSED].[aankomst];
CREATE TABLE [CLEANSED].[aankomst]
(
	VluchtId	int	NOT NULL	PRIMARY KEY,
	VliegtuigCode	varchar(10)	NULL,
	Terminal	char(1)	NULL,
	Gate	char(2)	NULL,
	Baan	int	NOT NULL,
	Bezetting	int	NULL,
	Vracht	int	NULL,
	Aankomsttijd	datetime	NULL,
	FOREIGN KEY (VluchtId) REFERENCES [CLEANSED].[vlucht](VluchtId),
	FOREIGN KEY (Baan) REFERENCES [CLEANSED].[banen](Baannummer)
);

-- Vertrek
DROP TABLE IF EXISTS [CLEANSED].[vertrek];
CREATE TABLE [CLEANSED].[vertrek]
(
	VluchtId	int	NOT NULL	PRIMARY KEY,
	Vliegtuigcode	varchar(10)	NULL,
	Terminal	char(1)	NULL,
	Gate	char(2)	NULL,
	Baan	int	NOT NULL,
	Bezetting	int	NULL,
	Vracht	int	NULL,
	Vertrektijd	datetime	NULL,
	FOREIGN KEY (VluchtId) REFERENCES [CLEANSED].[vlucht](VluchtId),
	FOREIGN KEY (Baan) REFERENCES [CLEANSED].[banen](Baannummer)
);

-- Klant
DROP TABLE IF EXISTS [CLEANSED].[klant];
CREATE TABLE [CLEANSED].[klant]
(
	VluchtId	int	NOT NULL	PRIMARY KEY,
	Operatie	float	NULL,
	Faciliteiten	float	NULL,
	Shops	float	NULL,
	FOREIGN KEY (VluchtId) REFERENCES [CLEANSED].[vlucht](VluchtId)
)

-- Luchthavens
DROP TABLE IF EXISTS [CLEANSED].[luchthavens];
CREATE TABLE [CLEANSED].[luchthavens]
(
	LuchthavenId	int	NOT NULL	IDENTITY	PRIMARY KEY,
	Naam	varchar(100)	NULL,
	Stad	varchar(50)	NULL,
    Land	varchar(50)	NULL,
	IATA	char(3)	NULL,
	ICAO	char(4)	NULL,
	Latitude	float	NULL,
	Longitude	float	NULL,
	Altitude	int	NULL,
	TZ	float	NULL,
	DS	char(1)	NULL,
	Area	varchar(100)	NULL
);

-- Planning
DROP TABLE IF EXISTS [CLEANSED].[planning];
CREATE TABLE [CLEANSED].[planning]
(
	Vluchtnr	varchar(8)	NOT NULL	PRIMARY KEY,
	Airlinecode	varchar(3)	NOT NULL,
	Destcode	char(3)	NOT NULL,
	Planterminal	char(1)	NULL,
	Plangate	char(2)	NULL,
	Plantijd	time	NULL
);

-- Weer
DROP TABLE IF EXISTS [CLEANSED].[weer];
CREATE TABLE [CLEANSED].[weer]
(
	Datum	date	NOT NULL	PRIMARY KEY,
	DDVEC	int	NULL,
	FHVEC	int	NULL,
	FG	int	NULL,
	FHX	int	NULL,
	FHXH	int	NULL,
	FHN	int	NULL,
	FHNH	int	NULL,
	FXX	int	NULL,
	FXXH	int	NULL,
	TG	int	NULL,
	TN	int	NULL,
	TNH	int	NULL,
	TX	int	NULL,
	TXH	int	NULL,
	T10N	int	NULL,
	T10NH	int	NULL,
	SQ	int	NULL,
	SP	int	NULL,
	Q	int	NULL,
	DR	int	NULL,
	RH	int	NULL,
	RHX	int	NULL,
	RHXH	int	NULL,
	PG	int	NULL,
	PX	int	NULL,
	PXH	int	NULL,
	PN	int	NULL,
	PNH	int	NULL,
	VVN	int	NULL,
	VVNH	int	NULL,
	VVX	int	NULL,
	VVXH	int	NULL,
	NG	int	NULL,
	UG	int	NULL,
	UX	int	NULL,
	UXH	int	NULL,
	UN	int	NULL,
	UNH	int	NULL,
	EV2	int	NULL
);
