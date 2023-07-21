SET SERVEROUTPUT ON;
SET VERIFY OFF;

DECLARE
a accounts.aid%TYPE:=&X;
b accounts.aname%TYPE:='&X';
c accounts.mno%TYPE:='&X';
d accounts.Balance%TYPE:='&X';
e accounts.Bname%TYPE:='&X';

BEGIN


INSERT INTO Accounts VALUES(a,b,c,d,e);




END;
/
commit;