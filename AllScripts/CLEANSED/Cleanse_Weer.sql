use VisionAiport_OLTP;

INSERT INTO [CLEANSED].[weer]
	SELECT 
		CAST(Datum AS datetime),
		CAST(DDVEC AS int), 
		CAST(FHVEC AS int), 
		CAST(FG AS int), 
		CAST(FHX AS int), 
		CAST(FHXH AS int), 
		CAST(FHN AS int), 
		CAST(FHNH AS int), 
		CAST(FXX AS int), 
		CAST(FXXH AS int), 
		CAST(TG AS int),
		CAST(TN AS int),
		CAST(TNH AS int),
		CAST(TX AS int),
		CAST(TXH AS int),
		CAST(T10N AS int),
		CAST(T10NH AS int),
		CAST(SQ AS int),
		CAST(SP AS int),
		CAST(Q AS int),
		CAST(DR AS int),
		CAST(RH AS int),
		CAST(RHX AS int),
		CAST(RHXH AS int),
		CAST(PG AS int),
		CAST(PX AS int),
		CAST(PXH AS int),
		CAST(PN AS int),
		CAST(PNH AS int),
		CAST(VVN AS int),
		CAST(VVNH AS int),
		CAST(VVX AS int),
		CAST(VVXH AS int),
		CAST(NG AS int),
		CAST(UG AS int),
		CAST(UX AS int),
		CAST(UXH AS int),
		CAST(UN AS int),
		CAST(UNH AS int),
		CAST(EV2 AS int)
	FROM [RAW].[export_weer];

	

