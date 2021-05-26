CREATE TABLE SUPPLIERS(sid INTEGER PRIMARY KEY, sname VARCHAR(20), address VARCHAR(20));
INSERT INTO suppliers VALUES(10001, 'Acme Widget','Bangalore');
INSERT INTO suppliers VALUES(10002, 'Johns','Kolkata');
INSERT INTO suppliers VALUES(10003, 'Vimal','Mumbai');
INSERT INTO suppliers VALUES(10004, 'Reliance','Delhi');
INSERT INTO suppliers VALUES(10005, 'Mahindra','Mumbai');
SELECT * FROM SUPPLIERS;
CREATE TABLE PARTS(pid INTEGER PRIMARY KEY, pname VARCHAR(20), color VARCHAR(10));
INSERT INTO PARTS VALUES(20001, 'Book','Red');
INSERT INTO PARTS VALUES(20002, 'Pen','Red');
INSERT INTO PARTS VALUES(20003, 'Pencil','Green');
INSERT INTO PARTS VALUES(20004, 'Mobile','Green');
INSERT INTO PARTS VALUES(20005, 'Charger','Black');
SELECT * FROM PARTS;
CREATE TABLE CATALOG(sid INTEGER, pid INTEGER,  FOREIGN KEY(sid) REFERENCES SUPPLIERS(sid), FOREIGN KEY(pid) REFERENCES PARTS(pid), cost FLOAT(6), PRIMARY KEY(sid, pid));
INSERT INTO CATALOG VALUES(10001, '20001','10');
INSERT INTO CATALOG VALUES(10001, '20002','10');
INSERT INTO CATALOG VALUES(10001, '20003','30');
INSERT INTO CATALOG VALUES(10001, '20004','10');
INSERT INTO CATALOG VALUES(10001, '20005','10');
INSERT INTO CATALOG VALUES(10002, '20001','10');
INSERT INTO CATALOG VALUES(10002, '20002','20');
INSERT INTO CATALOG VALUES(10003, '20003','30');
INSERT INTO CATALOG VALUES(10004, '20003','40');
SELECT * FROM CATALOG;
SELECT DISTINCT P.pname FROM Parts P, Catalog C WHERE P.pid = C.pid;
SELECT S.sname FROM Suppliers S WHERE NOT EXISTS(SELECT P.pid,C.pid FROM Parts P,Catalog C WHERE C.sid = S.sid);
SELECT S.sname FROM Suppliers S WHERE EXISTS((SELECT C.pid FROM Catalog C, Parts P WHERE C.sid = S.sid AND C.pid = P.pid  AND P.color='red'));
SELECT P.pname FROM Parts P, Catalog C,Suppliers S WHERE P.pid=C.pid AND C.sid=S.sid AND S.sname='Acme Widget' AND NOT EXISTS(SELECT *FROM Catalog C1,Suppliers S1 WHERE P.pid=C1.pid AND C1.sid=S1.sid AND S1.sname <> 'Acme Widget');
SELECT DISTINCT C.sid FROM Catalog C WHERE C.cost > ( SELECT AVG (C1.cost)FROM Catalog C1 WHERE C1.pid = C.pid );
SELECT P.pid, S.sname FROM Parts P, Suppliers S, Catalog C WHERE C.pid = P.pid AND C.sid = S.sid AND C.cost = (SELECT MAX(C1.cost)FROM Catalog C1 WHERE C1.pid = P.pid );
SELECT DISTINCT C.sid FROM Catalog C WHERE NOT EXISTS(SELECT *FROM Parts P WHERE P.pid = C.pid AND P.color <> 'Red');