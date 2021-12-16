Use VisionAiport_OLTP;


-- Aankomst
CREATE TABLE CLEANSED.aankomst
	(
	Vluchtid int NULL,
	Vliegtuigcode nchar(10) NULL,
	Terminal nchar(5) NULL,
	Gate nchar(5) NULL,
	Baan int NULL,
	Bezetting int NULL,
	Vracht nchar(5) NULL,
	Aankomsttijd datetime NULL
	);

-- Banen
CREATE TABLE CLEANSED.banen
	(
	Baannummer int NULL,
	Code nchar(10) NULL,
	Naam nchar(50) NULL,
	Lengte int NULL
	);

-- Klant
CREATE TABLE CLEANSED.klant
	(
	Vluchtid int NULL,
	Operatie decimal(18, 2) NULL,
	Faciliteiten decimal(18, 2) NULL,
	Shops decimal(18, 2) NULL
	)

-- Luchthavens
CREATE TABLE CLEANSED.luchthavens
	(
	Airport nvarchar(100) NULL,
	City nvarchar(50) NULL,
    Country nvarchar(40) NULL,
	IATA nchar(10) NULL,
	ICAO nchar(10) NULL,
	Lat decimal(11, 9) NULL,
	Lon decimal(11, 9) NULL,
	Alt int NULL,
	TZ decimal(4, 3) NULL,
	DST nchar(3) NULL,
	T_Z varchar(50) NULL
	);

-- Maatschappijen
CREATE TABLE CLEANSED.maatschappijen
	(
	Name varchar(50) NULL,
	IATA nchar(10) NULL,
	ICAO nchar(10) NULL
	);

-- Planning
CREATE TABLE CLEANSED.Planning
	(
	Vluchtnr nchar(10) NULL,
	airlinecode nchar(10) NULL,
	Destcode nchar(5) NULL,
	Planterminal nchar(3) NULL,
	Plangate nchar(3) NULL,
	Plantijd datetime NULL
	);

-- Vertrek
CREATE TABLE CLEANSED.Vertrek
	(
	Vluchtid int NULL,
	Vliegtuigcode char(10) NULL,
	Terminal char(2) NULL,
	Gate nchar(3) NULL,
	Baan int NULL,
	Bezetting int NULL,
	Vracht int NULL,
	Vertrektijd datetime NULL
	);
	
-- Vliegtuig
CREATE TABLE CLEANSED.Vliegtuig
	(
	Airlinecode nchar(10) NULL,
	Vliegtuigcode nchar(10) NULL,
	Vliegtuigtype nchar(5) NULL,
	Bouwjaar int NULL
	);
	
--Vliegtuigtype
CREATE TABLE CLEANSED.Vliegtuigtype
	(
	IATA nchar(10) NULL,
	ICAO nchar(10) NULL,
	Merk nvarchar(50) NULL,
	Type nvarchar(100) NULL,
	Wake nchar(5) NULL,
	Cat nchar(20) NULL,
	Capaciteit int NULL,
	Vracht int NULL
	);

-- Vlucht
CREATE TABLE CLEANSED.Vlucht
	(
	Vluchtid int NULL,
	Vluchtnr nvarchar(20) NULL,
	Airlinecode nchar(5) NULL,
	Destcode nchar(5) NULL,
	Vliegtuigcode nchar(10) NULL,
	Datum date NULL
	);

-- Weer
CREATE TABLE CLEANSED.weer
	(
	Datum date NULL,
	DDVEC int NULL,
	FHVEC int NULL,
	FG int NULL,
	FHX int NULL,
	FHXH int NULL,
	FHN int NULL,
	FHNH int NULL,
	FXX int NULL,
	FXXH int NULL,
	TG int NULL,
	TN int NULL,
	TNH int NULL,
	TX int NULL,
	TXH int NULL,
	T10N int NULL,
	T10NH int NULL,
	SQ int NULL,
	SP int NULL,
	Q int NULL,
	DR int NULL,
	RH int NULL,
	RHX int NULL,
	RHXH int NULL,
	PG int NULL,
	PX int NULL,
	PXH int NULL,
	PN int NULL,
	PNH int NULL,
	VVN int NULL,
	VVNH int NULL,
	VVX int NULL,
	VVXH int NULL,
	NG int NULL,
	UG int NULL,
	UX int NULL,
	UXH int NULL,
	UN int NULL,
	UNH int NULL,
	EV2 int NULL
	);
