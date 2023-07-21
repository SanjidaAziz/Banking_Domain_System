SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE PACKAGE mypack AS

	FUNCTION check_balance(A1 IN Integer)
	RETURN Integer;
END mypack;
/

CREATE OR REPLACE PACKAGE BODY mypack AS

	FUNCTION check_balance(A1 IN Integer)
	RETURN Integer
	IS 
	
	b Integer;
	
	BEGIN
		select balance into b from accounts where aid = A1;
		return b;
	END check_balance;
	
END mypack;
/


accept x number prompt 'Please enter account id to check balance: '

DECLARE
	D Integer;
BEGIN
	D := &x;
	D := mypack.check_balance(D);
	DBMS_OUTPUT.PUT_LINE('Your balance is : '||D);
	
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Not Found');

END;
/
