CREATE TABLE salesman(salesman_id INT PRIMARY KEY,sname VARCHAR(20),city VARCHAR(20),commission VARCHAR(20));
CREATE TABLE customer(customer_id INT,cust_name VARCHAR(20),city VARCHAR(20),grade INT,salesman_id INT,PRIMARY KEY(customer_id),FOREIGN KEY(salesman_id)REFERENCES salesman(salesman_id)ON DELETE CASCADE);
CREATE TABLE orderr(ord_no INT,purchase_amt INT,ord_date DATE,customer_id INT,salesman_id INT,PRIMARY KEY(ord_no),FOREIGN KEY(customer_id)REFERENCES customer(customer_id)ON DELETE CASCADE,FOREIGN KEY(salesman_id)REFERENCES salesman(salesman_id)ON DELETE CASCADE);
INSERT INTO SALESMAN VALUES (1000,'JOHN','BANGALORE','25 %'); 
INSERT INTO SALESMAN VALUES (2000,'RAVI','BANGALORE','20 %'); 
INSERT INTO SALESMAN VALUES (3000,'KUMAR','MYSORE','15 %'); 
INSERT INTO SALESMAN VALUES (4000,'SMITH','DELHI','30 %'); 
INSERT INTO SALESMAN VALUES (5000,'HARSHA','HYDRABAD','15 %'); 
SELECT *FROM salesman;
INSERT INTO CUSTOMER VALUES (10,'PREETHI','BANGALORE', 100, 1000); 
INSERT INTO CUSTOMER VALUES (11,'VIVEK','MANGALORE', 300, 1000); 
INSERT INTO CUSTOMER VALUES (12,'BHASKAR','CHENNAI', 400, 2000); 
INSERT INTO CUSTOMER VALUES (13,'CHETHAN','BANGALORE', 200, 2000); 
INSERT INTO CUSTOMER VALUES (14,'MAMATHA','BANGALORE', 400, 3000); 
SELECT *FROM customer;
INSERT INTO ORDERR VALUES (50, 5000,'17-05-04', 10, 1000); 
INSERT INTO ORDERR VALUES (51, 450,'17-01-20', 10, 2000);
INSERT INTO ORDERR VALUES (52, 1000,'17-02-24', 13, 2000); 
INSERT INTO ORDERR VALUES (53, 3500,'17-04-13', 14, 3000); 
INSERT INTO ORDERR VALUES (54, 550,'17-03-09', 12, 2000);
SELECT *FROM ORDERR;
SELECT GRADE, COUNT(DISTINCT CUSTOMER_ID)FROM CUSTOMER GROUP BY GRADE HAVING GRADE>(SELECT AVG(GRADE)FROM CUSTOMER WHERE CITY='BANGALORE');
SELECT SALESMAN_ID,SNAME FROM SALESMAN A WHERE 1 < (SELECT COUNT(*)FROM CUSTOMER WHERE SALESMAN_ID=A.SALESMAN_ID);
SELECT SALESMAN.SALESMAN_ID, SNAME, CUST_NAME, COMMISSION FROM SALESMAN, CUSTOMER WHERE SALESMAN.CITY = CUSTOMER.CITY UNION SELECT SALESMAN_ID, SNAME,'NO MATCH',COMMISSION FROM SALESMAN WHERE NOT CITY=ANY(SELECT CITY FROM CUSTOMER)ORDER BY 2 DESC;
CREATE VIEW ELITSALESMAN AS SELECT B.ORD_DATE, A.SALESMAN_ID, A.SNAME FROM SALESMAN A, ORDERR B WHERE A.SALESMAN_ID = B.SALESMAN_ID AND B.PURCHASE_AMT=(SELECT MAX(PURCHASE_AMT)FROM ORDERR C WHERE C.ORD_DATE = B.ORD_DATE);
SELECT *FROM ELITSALESMAN;
DELETE FROM SALESMAN WHERE SALESMAN_ID=1000;
SELECT *FROM SALESMAN;