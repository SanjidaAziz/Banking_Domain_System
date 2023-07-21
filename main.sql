SET SERVEROUTPUT ON;
DECLARE
	a accounts.aid%TYPE;
BEGIN
	--deposit(3,20);
	a := withdraw(1001,20);
	
END;
/