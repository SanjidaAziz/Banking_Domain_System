SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE deposit(A1 IN accounts.aid%TYPE, B1 in accounts.Balance%TYPE)
IS

a accounts.aid%TYPE;
a2 accounts.aid%TYPE;
a3 accounts.aid%TYPE;
b accounts.aname%TYPE;
c accounts.mno%TYPE;
d accounts.Balance%TYPE;

BEGIN
	select count(aid) into a from accounts WHERE aid = A1;
	select count(aid) into a2 from accounts@tonny WHERE aid = A1;
	select count(aid) into a3 from accounts@rifat WHERE aid = A1;
	
	if a=1 then 
		select balance into d from accounts WHERE aid = A1;
		d := d + B1;
		update accounts set balance = d where aid = A1;
		
	ELSIF a2=1 then 
		select balance into d from accounts@tonny WHERE aid = A1;
		d := d + B1;
		update accounts@tonny set balance = d where aid = A1;
		
	else 
		select balance into d from accounts@rifat WHERE aid = A1;
		d := d + B1;
		update accounts@rifat set balance = d where aid = A1;
	end if;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('No Data Found');
			
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE('Too Many Rows');
END deposit;
/

CREATE OR REPLACE FUNCTION WITHDRAW(A1 IN accounts.aid%TYPE, B1 in accounts.Balance%TYPE)
return Integer
IS

a accounts.aid%TYPE;
a2 accounts.aid%TYPE;
a3 accounts.aid%TYPE;
b accounts.aname%TYPE;
c accounts.mno%TYPE;
d accounts.Balance%TYPE;

BEGIN
	select count(aid) into a from accounts WHERE aid = A1;
	select count(aid) into a2 from accounts@tonny WHERE aid = A1;
	select count(aid) into a3 from accounts@rifat WHERE aid = A1;
	
	if a=1 then 
		select aid,aname,mno,balance into a,b,c,d from accounts WHERE aid = A1;
		IF d >= B1 then
			d := d - B1;
		update accounts set balance = d where aid = A1;
		return 1;
		else 
		dbms_output.put_line('Not sufficient balance');
		return 0;
		end if;
	
	ELSIF a2=1 then
		select aid,aname,mno,balance into a,b,c,d from accounts@rifat WHERE aid = A1;
			IF d >= B1 then
				d := d - B1;
				update accounts@rifat set balance = d where aid = A1;
				return 1;
			else 
				dbms_output.put_line('Not sufficient balance');
				return 0;
			end if;
			
	else 
		select aid,aname,mno,balance into a,b,c,d from accounts@rifat WHERE aid = A1;
			IF d >= B1 then
				d := d - B1;
				update accounts@rifat set balance = d where aid = A1;
				return 1;
			else 
				dbms_output.put_line('Not sufficient balance');
				return 0;
			end if;
			
	end if;
END withdraw;
/

CREATE OR REPLACE PROCEDURE applyloan(B1 in accounts.Balance%TYPE)
IS

a accounts.aid%TYPE;
b accounts.aname%TYPE;
c accounts.mno%TYPE;
d accounts.Balance%TYPE;
e accounts.Balance%TYPE;

BEGIN
	SELECT SUM(Balance) into d FROM ((select aid,balance from accounts union select aid,balance from accounts@rifat) union select aid,balance from accounts@rifat);
	SELECT SUM(LAmmount) into e FROM loan;
	d := d * 0.8;
	d := d - e;
	
	if d >= B1 then 
		dbms_output.put_line('Maximum Loan amount : '||d);
		dbms_output.put_line('Requested loan amount : '||B1);
		dbms_output.put_line('loan is elligible');
	else 
		dbms_output.put_line('Maximum Loan amount : '||d);
		dbms_output.put_line('Requested loan amount : '||B1);
		dbms_output.put_line('loan not elligible');
	end if;
	
	
	
END applyloan;
/

CREATE OR REPLACE PROCEDURE giveloan(A1 in accounts.aid%TYPE,B1 in accounts.Balance%TYPE, C1 in loan.Ldate%TYPE)
IS

a accounts.aid%TYPE;
b accounts.aname%TYPE;
c accounts.mno%TYPE;
d accounts.Balance%TYPE;
e accounts.Balance%TYPE;

BEGIN
	SELECT SUM(Balance) into d FROM ((select aid,balance from accounts union select aid,balance from accounts@rifat) union select aid,balance from accounts@tonny);
	SELECT SUM(LAmmount) into e FROM loan;
	d := d * 0.8;
	d := d - e;
	
	if d >= B1 then 
		insert into loan values(A1,B1,C1);
		insert into loan@rifat values(A1,B1,C1);
		
	else 
		dbms_output.put_line('Maximum Loan amount : '||d);
		dbms_output.put_line('Requested loan amount : '||B1);
		dbms_output.put_line('loan not elligible');
	end if;
	
	
	
END giveloan;
/

CREATE OR REPLACE PROCEDURE transfer(A1 IN accounts.aid%TYPE, B1 in accounts.Balance%TYPE, A2 IN accounts.aid%TYPE)
IS

BEGIN
	if withdraw(A1,B1)=1 THEN
		deposit(A2,B1);
	else 
		dbms_output.put_line('Transfer unsuccessful !');
	end if;
END transfer;
/

CREATE OR REPLACE PROCEDURE deleteaccount(A1 IN accounts.aid%TYPE)
IS

a accounts.aid%TYPE;
a2 accounts.aid%TYPE;
a3 accounts.aid%TYPE;


BEGIN
	select count(aid) into a from accounts WHERE aid = A1;
	select count(aid) into a2 from accounts@tonny WHERE aid = A1;
	select count(aid) into a3 from accounts@rifat WHERE aid = A1;
	
	if a=1 then 		
		delete from accounts where aid = A1;
		
	ELSIF a2=1 then 		
		delete from accounts@tonny where aid = A1;
		
	else 
		delete from accounts@rifat where aid = A1;
	end if;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('No Data Found');
			
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE('Too Many Rows');
END deleteaccount;
/


CREATE OR REPLACE TRIGGER updated 
AFTER INSERT
ON accounts
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Account created SUCCESSFULLY');
END;
/

CREATE OR REPLACE TRIGGER dltaccnt 
AFTER DELETE
ON accounts
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('An account has been deleted permanently');
END;
/


commit;


