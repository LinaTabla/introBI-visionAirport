use VisionAiport_OLTP;

-- Copy structure of RAW files to make ARCHIVE files
select top 0 * into ARCHIVE.aankomst from RAW.export_aankomst;

select top 0 * into ARCHIVE.banen from RAW.export_banen;

select top 0 * into ARCHIVE.klant from RAW.export_klant;

select top 0 * into ARCHIVE.luchthavens from RAW.export_luchthavens;

select top 0 * into ARCHIVE.maatschappijen from RAW.export_maatschappijen;

select top 0 * into ARCHIVE.planning from RAW.export_planning;

select top 0 * into ARCHIVE.vertrek from RAW.export_vertrek;

select top 0 * into ARCHIVE.vliegtuig from RAW.export_vliegtuig;

select top 0 * into ARCHIVE.vliegtuigtype from RAW.export_vliegtuigtype;

select top 0 * into ARCHIVE.vlucht from RAW.export_vlucht;

select top 0 * into ARCHIVE.weer from RAW.export_weer;