-- 1. create OLTP database
DROP DATABASE IF EXISTS VisionAirport_OLTP;
CREATE DATABASE VisionAirport_OLTP;
USE VisionAirport_OLTP;

-- 2. create schema's in db VisionAirport_OLTP
CREATE SCHEMA [RAW];
GO
CREATE SCHEMA [ARCHIVE];
GO
CREATE SCHEMA [CLEANSED];
GO

-- 3. import flat data files in [VisionAirport_OLTP].[RAW] > Import Wizard
