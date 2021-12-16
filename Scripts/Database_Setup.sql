-- 1. create DWH database
DROP DATABASE IF EXISTS VisionAirport_DWH;
CREATE DATABASE VisionAirport_DWH;

-- 2. create OLTP database
DROP DATABASE IF EXISTS VisionAirport_OLTP;
CREATE DATABASE VisionAirport_OLTP;
GO

-- 3. create schema's in db VisionAirport_OLTP
CREATE SCHEMA [RAW];
GO
CREATE SCHEMA [ARCHIVE];
GO
CREATE SCHEMA [CLEANSED];
GO
