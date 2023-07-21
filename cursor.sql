SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE allaccounts
IS

a accounts.aid%TYPE;
b accounts.aname%TYPE;
c accounts.mno%TYPE;
d accounts.balance%TYPE;
e accounts.bname%TYPE;

BEGIN
	FOR R IN ((SELECT * FROM accounts UNION select * from accounts@tonny) UNION SELECT * FROM accounts@rifat) LOOP
		a := R.aid;
		b := R.aname;
		c := R.mno;
		d := R.balance;
		e := R.bname;
		dbms_output.put_line(a||' '||b||' '||c||' '||d||' '||e);
	END LOOP;
	
	

END allaccounts;
/

CREATE OR REPLACE PROCEDURE jurisdiction
IS

a accounts.aid%TYPE;
b accounts.aname%TYPE;
c accounts.mno%TYPE;
d accounts.balance%TYPE;
e accounts.bname%TYPE;
f branch.bmanager%type;

BEGIN
	FOR R IN (select aid,aname,mno,balance,a.bname,bmanager from ((SELECT * FROM accounts UNION select * from accounts@tonny) UNION SELECT * FROM accounts@rifat) a INNER JOIN BRANCH b ON a.bname=b.bname) LOOP
		a := R.aid;
		b := R.aname;
		c := R.mno;
		d := R.balance;
		e := R.bname;
		f := R.bmanager;
		
		dbms_output.put_line(a||' '||b||' '||c||' '||d||' '||e||' '||f);
	END LOOP;
	
	

END jurisdiction;
/

commit;
