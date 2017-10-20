DROP TABLE IF EXISTS book CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS faculty CASCADE;
DROP TABLE IF EXISTS enroll CASCADE;
DROP TABLE IF EXISTS book_checkout CASCADE;

----------------------------------------------------------------------

CREATE TABLE book
		(
			bookid       int,
			title 		 varchar(50),
			price 		 numeric(5, 0),
			total_copies int,
			PRIMARY KEY  (bookid)
		);

DELETE FROM book;

INSERT INTO book VALUES ('1', 'Introduction of Algorithms', '84.66', '4');
INSERT INTO book VALUES ('2', 'Database System Concepts', '74.99', '5');
INSERT INTO book VALUES ('3', 'Stochastic Calculus for Finance I', '41.02', '3');
INSERT INTO book VALUES ('4', 'Stochastic Calculus for Finance II', '55.22', '3');

-------------------------------------------------------------------------------------
CREATE TABLE student
		(
			studentid    int,
			name 		 varchar(25),
			gpa          numeric(3,0),
			PRIMARY KEY  (studentid)
		);
		
DELETE FROM student;

INSERT INTO student VALUES ('1', 'Tom', '3.3');
INSERT INTO student VALUES ('2', 'John', '3.8');
INSERT INTO student VALUES ('3', 'Mary', '3.0');
INSERT INTO student VALUES ('4', 'Kris', '3.6');
INSERT INTO student VALUES ('5', 'Alex', '3.5');

---------------------------------------------------------------------------------
		
CREATE TABLE faculty
		(
			facultyid    int,
			name 		 varchar(25),
			salary       numeric(8,0),
			PRIMARY KEY  (facultyid)
		);
		
DELETE FROM faculty;

INSERT INTO faculty VALUES ('1', 'James', '70000');
INSERT INTO faculty VALUES ('2', 'Sarah', '60000');
INSERT INTO faculty VALUES ('3', 'Jay', '80000');
INSERT INTO faculty VALUES ('4', 'Rachel', '70000');
INSERT INTO faculty VALUES ('5', 'Paul', '85000');
		
CREATE TABLE course
		(
			courseid 	  int,
			title         varchar(50),
			instructorid  int,
			textbookid    int,
			PRIMARY KEY   (courseid),
			FOREIGN KEY   (instructorid) REFERENCES faculty on DELETE CASCADE,
			FOREIGN KEY   (texkbookid) REFERENCES book on DELETE CASCADE
		);
		
DELETE FROM course;

INSERT INTO course VALUES ('1', 'Algorithms', '1' ,'1');
INSERT INTO course VALUES ('2', 'DB Organization', '2' ,'2');
INSERT INTO course VALUES ('3', 'Advanced DB Organization', '3' ,'2');
INSERT INTO course VALUES ('4', 'Math Finance I', '1' ,'3');
INSERT INTO course VALUES ('5', 'Math Finance II', '4' ,'4');

--------------------------------------------------------------------------
		
CREATE TABLE enroll
		(
			studentid    int,
			courseid     int,
			PRIMARY KEY  (studentid, courseid),
			FOREIGN KEY  (studentid) REFERENCES student on DELETE CASCADE
			FOREIGN KEY  (courseid) REFERENCES course on DELETE CASCADE
		);
		
DELETE FROM enroll;

INSERT INTO enroll VALUES ('1', '1');
INSERT INTO enroll VALUES ('1', '2');
INSERT INTO enroll VALUES ('2', '1');
INSERT INTO enroll VALUES ('4', '3');
INSERT INTO enroll VALUES ('4', '4');
INSERT INTO enroll VALUES ('5', '5');

------------------------------------------------------------------------------------------

CREATE TABLE book_checkout
		(
			checkout_date  date,
			bookid         int,
			studentid      int,
			PRIMARY KEY    (bookid, studentid),
			FOREIGN KEY    (bookid) REFERENCES book on DELETE CASCADE
			FOREIGN KEY    (studentid) REFERENCES student on DELETE CASCADE
		);
		


DELETE FROM book_checkout;


INSERT INTO book_checkout VALUES ('2017-08-29', '1', '1');
INSERT INTO book_checkout VALUES ('2017-09-02', '4', '4');
INSERT INTO book_checkout VALUES ('2017-09-07', '1', '4');
