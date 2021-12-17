USE [VisionAirport_DWH];
GO

DROP TABLE IF EXISTS FactVlucht;
DROP TABLE IF EXISTS DimMaatschappij;
DROP TABLE IF EXISTS DimVliegtuigType;
DROP TABLE IF EXISTS DimVliegtuig;
DROP TABLE IF EXISTS DimDatum;
DROP TABLE IF EXISTS DimBanen;
DROP TABLE IF EXISTS DimLuchthaven;
DROP TABLE IF EXISTS DimGate;


CREATE TABLE DimMaatschappij
(
	MaatschappijID		INT		IDENTITY(1,1),
	Naam				VARCHAR(50)	COLLATE Latin1_General_CI_AS	NOT NULL,
	IATA				CHAR(3)		COLLATE Latin1_General_CI_AS	NOT NULL,
	ICAO				CHAR(4)		COLLATE Latin1_General_CI_AS	NULL,
	PRIMARY KEY (MaatschappijID)
);

CREATE TABLE DimVliegtuigType
(
	VliegtuigTypeID		INT	IDENTITY(1,1),
	Categorie			varchar(20) 	NULL,
	IATA				varchar(3)			NOT NULL,
	ICAO				varchar(4)			NULL,
	Merk				varchar(50) 	NOT NULL,
	Type				varchar(100) 	NOT NULL,
	Wake				char(1) 		NULL,
	Capaciteit	int 			NOT NULL,
	VrachtCapaciteit	int 			NOT NULL,
	PRIMARY KEY (VliegtuigTypeID)
);

CREATE TABLE DimVliegtuig
(
	VliegtuigID			INT IDENTITY(1,1) 		NOT NULL,
	MaatschappijID		INT 					NULL,
	VliegtuigtypeID		INT 					NOT NULL,
	VliegtuigCode		VARCHAR(10) 			NOT NULL,
	Bouwjaar			INT 					NOT NULL,
	PRIMARY KEY (VliegtuigID),
	FOREIGN KEY (MaatschappijID) REFERENCES DimMaatschappij(MaatschappijID),
	FOREIGN KEY (VliegtuigtypeID) REFERENCES DimVliegtuigType(VliegtuigtypeID)
);

CREATE TABLE DimDatum
(
	DatumID int	IDENTITY(1,1),
	Datum	datetime	NOT NULL,
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
	EV2	int	NULL,
	PRIMARY KEY (DatumID)
);

CREATE TABLE DimBanen
(
	BaanID		INT			IDENTITY(1,1),
	BaanCode	VARCHAR(7)	NOT NULL,
	Naam		VARCHAR(50) NOT NULL,
	Lengte		INT 		NOT NULL,
	PRIMARY KEY (BaanID)
)

CREATE TABLE DimLuchthaven
(
	LuchthavenID	INT		IDENTITY(1,1),
	Naam			VARCHAR(100) 	NOT NULL,
	Stad			VARCHAR(50) 	NOT NULL,
	Land			VARCHAR(50) 	NOT NULL,
	IATA			VARCHAR(3)		NULL,
	ICAO			VARCHAR(4) 		NOT NULL,
	Lat				FLOAT 			NOT NULL,
	Lon				FLOAT 			NOT NULL,
	ALT				SMALLINT 		NOT NULL,
	TZ	FLOAT		 	NOT NULL,
	DST				CHAR(1) 		NOT NULL,
	Area		VARCHAR(100) 	NULL,
	PRIMARY KEY (LuchthavenID)
);

CREATE TABLE DimGate
(
	GateID		INT			IDENTITY(1,1),
	GateCode	CHAR(2)		NULL,
	Terminal	CHAR(1) 	NOT NULL,
	PRIMARY KEY (GateID)
);

CREATE TABLE FactVlucht
(
	VluchtID				INT,
	VliegtuigID				INT,
	IsVertrek				bit,
	MaatschappijID			INT,
	DatumID					INT,
	BaanID					INT,
	LuchthavenID			INT,
	GateID					INT,
	VluchtCode				VARCHAR(10)		NULL,
	Bezetting				INT				NULL,
	Vracht					INT				NULL,
	PRIMARY KEY (VluchtID),
	FOREIGN KEY (VliegtuigID) REFERENCES DimVliegtuig(VliegtuigID),
	FOREIGN KEY (MaatschappijID) REFERENCES DimMaatschappij(MaatschappijID),
	FOREIGN KEY (DatumID) REFERENCES DimDatum(DatumID),
	FOREIGN KEY (BaanID) REFERENCES DimBanen(BaanID),
	FOREIGN KEY (LuchthavenID) REFERENCES DimLuchthaven(LuchthavenID),
	FOREIGN KEY (GateID) REFERENCES DimGate(GateID)
);