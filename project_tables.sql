DROP TABLE Accounts;
DROP TABLE Branch;
DROP TABLE Loan;
DROP TABLE TRANSACTION; 
set lines 3000;
create table Accounts(AID Integer,  Aname VARCHAR2(40), MNO VARCHAR2(40), Balance Integer,Bname VARCHAR2(30));
INSERT INTO Accounts VALUES(1,'Zahid','01983123456',300,'Dhaka');
INSERT INTO Accounts VALUES(2,'B','01283123456',200,'Dhaka');
INSERT INTO Accounts VALUES(3,'C','01383123456',100,'Dhaka');
select * from Accounts;


CREATE TABLE Branch(BID Integer,Bname VARCHAR2(30),bmanager Varchar2(30));
INSERT INTO Branch VALUES(1,'Dhaka','Md Zahidul Haque');
INSERT INTO Branch VALUES(101,'Rajshahi','Kh Rifat Amin');
INSERT INTO Branch VALUES(1001,'Feni','Sanjida Aziz Tonny');
select * from Branch;


CREATE TABLE Loan(AID Integer, LAmmount Integer, Ldate VARCHAR2(20));   
insert into loan values(0,0,'00-00-0000');
select * from Loan;

 
CREATE TABLE TRANSACTION(TNO Integer, AID Integer, DOT VARCHAR2(20), TransactionType VARCHAR2(20), TransactionAmount Integer);	 
INSERT INTO TRANSACTION VALUES(1,1,'2022-08-22','Deposit',50000);
select * from TRANSACTION;	


commit;



   
   
--SELECT mypack.F1(20) FROM DUAL;
--EXEC mypack.P1(21);