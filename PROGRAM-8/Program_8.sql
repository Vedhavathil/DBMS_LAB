CREATE TABLE student(regno VARCHAR(15),NAME VARCHAR(20),major VARCHAR(20),bdate DATE,PRIMARY KEY (regno) );
CREATE TABLE course(courseno INT,cname VARCHAR(20),dept VARCHAR(20),PRIMARY KEY (courseno) );
CREATE TABLE enroll(regno VARCHAR(15),courseno INTEGER,sem INTEGER,marks INTEGER,PRIMARY KEY(regno,courseno),FOREIGN KEY(regno)REFERENCES student(regno),FOREIGN KEY(courseno)REFERENCES course(courseno));
CREATE TABLE text_book(book_isbn INT(5),book_title VARCHAR(20),publisher VARCHAR(20),author VARCHAR(20),PRIMARY KEY (book_isbn) );
CREATE TABLE book_adoption(courseno INT,sem INT(3),book_isbn INT(5),PRIMARY KEY(courseno,book_isbn),FOREIGN KEY(courseno)REFERENCES course (courseno),FOREIGN KEY (book_isbn) REFERENCES text_book(book_isbn) );
INSERT INTO student VALUES('1pe11cs002','b','sr','19930924');
INSERT INTO student VALUES('1pe11cs003','c','sr','19931127');
INSERT INTO student VALUES('1pe11cs004','d','sr','19930413');
INSERT INTO student VALUES('1pe11cs005','e','jr','19940824');
INSERT INTO course VALUES(111,'OS','CSE');
INSERT INTO course VALUES(112,'EC','CSE');
INSERT INTO course VALUES(113,'SS','ISE');
INSERT INTO course VALUES(114,'DBMS','CSE');
INSERT INTO course VALUES(115,'SIGNALS','ECE');
INSERT INTO text_book VALUES(10,'DATABASE SYSTEMS','PEARSON','SCHIELD');
INSERT INTO text_book VALUES(900,'OPERATING SYS','PEARSON','LELAND');
INSERT INTO text_book VALUES(901,'CIRCUITS','HALL INDIA','BOB');
INSERT INTO text_book VALUES(902,'SYSTEM SOFTWARE','PETERSON','JACOB');
INSERT INTO text_book VALUES(903,'SCHEDULING','PEARSON','PATIL');
INSERT INTO text_book VALUES(904,'DATABASE SYSTEMS','PEARSON','JACOB');
INSERT INTO text_book VALUES(905,'DATABASE MANAGER','PEARSON','BOB');
INSERT INTO text_book VALUES(906,'SIGNALS','HALL INDIA','SUMIT');
INSERT INTO enroll VALUES('1pe11cs002',114,5,100);
INSERT INTO enroll VALUES ('1pe11cs003',113,5,100);
INSERT INTO enroll VALUES ('1pe11cs004',111,5,100);
INSERT INTO enroll VALUES ('1pe11cs005',112,3,100);
INSERT INTO book_adoption VALUES (111,5,900);
INSERT INTO book_adoption VALUES (111,5,903);
INSERT INTO book_adoption VALUES (111,5,904);
INSERT INTO book_adoption VALUES (112,3,901);
INSERT INTO book_adoption VALUES (113,3,10);
INSERT INTO book_adoption VALUES (114,5,905);
INSERT INTO book_adoption VALUES (113,5,902);
INSERT INTO book_adoption VALUES (115,3,906);
SELECT *FROM student;
SELECT*FROM course;
SELECT *FROM text_book;
SELECT *FROM enroll;
SELECT *FROM book_adoption;
#query-1
INSERT INTO text_book VALUES(908,'UNIX CINCEPTS','TATA MCGRAW HILL','SUSMITABHA DAS');
INSERT INTO book_adoption VALUES(113,4,908);
SELECT*FROM text_book;
SELECT*FROM book_adoption;

#query-2
SELECT c.courseno,t.book_isbn,t.book_title FROM course c,book_adoption ba,text_book t WHERE c.courseno=ba.courseno AND ba.book_isbn=t.book_isbn AND c.dept='CSE' AND 2<(SELECT COUNT(book_isbn) FROM book_adoption b WHERE c.courseno=b.courseno)ORDER BY t.book_title;

#query-3
SELECT DISTINCT c.dept FROM course c WHERE c.dept IN( SELECT c.dept FROM course c,book_adoption b,text_book t WHERE c.courseno=b.courseno AND t.book_isbn=b.book_isbn AND t.publisher='PEARSON')AND c.dept IN
(SELECT c.dept FROM course c,book_adoption b,text_book t WHERE c.courseno=b.courseno AND t.book_isbn=b.book_isbn AND t.publisher != 'PEARSON');
