
INSERT INTO ARCHIVE.aankomst
		(Vluchtid, Vliegtuigcode, Terminal, Gate, Baan, Bezetting, Vracht, Aankomsttijd)
	SELECT 
		Vluchtid,
		Vliegtuigcode,
		Terminal,
		Gate,
		Baan,
		Bezetting,
		Vracht,
		Aankomsttijd 
	FROM 
		raw.export_aankomst 
	WHERE 
		Aankomsttijd = '' OR 
		Vliegtuigcode = '' OR 
		Terminal = '' OR 
		Baan = '' OR 
		(Vracht != '' AND (Gate != ''  OR Bezetting != '')) OR 
		(Vracht = '' AND (Gate = '' OR Bezetting = ''))
