create database TinyHub;
use TinyHub;

Create table TinyHub.users (emailId varchar(100) not null primary key,
							displayName varchar(100) unique not null,
							password varchar(15) not null,
							userType varchar(10) not null
							);
							
Create table TinyHub.department (departmentNo int not null primary key,
								 departmentName varchar(100) not null
								 );
								
Create table TinyHub.courses (courseId int not null primary key,
							  courseName varchar(100) not null,
							  capacity int not null,
							  departmentNo int not null,
							  foreign key(departmentNo) references department(departmentNo)
							  );
							
Create table TinyHub.programs (programId int not null primary key,
							   programName varchar(100) not null,
							   departmentNo int not null,
							   foreign key(departmentNo) references department(departmentNo)
							   );

Create table TinyHub.semester (year_season varchar(100) not null primary key);

Create table TinyHub.student (studentId int not null primary key,
							  studentName varchar(100) not null,
							  emailId varchar(100) not null,
							  foreign key(emailId) references users(emailId)
							  );
								
Create table TinyHub.professor (professorId int not null primary key,
								professorName varchar(100) not null,
								emailId varchar(100) not null,
								departmentNo int not null,
								foreign key(emailId) references users(emailId),
								foreign key(departmentNo) references department(departmentNo)
								);
								
Create table TinyHub.staff (staffId int not null primary key,
							staffName varchar(100) not null,
							emailId varchar(100) not null,
							departmentNo int,
							foreign key(emailId) references users(emailId),
							foreign key(departmentNo) references department(departmentNo)
							);
							
Create table TinyHub.majors (studentId int not null,
							 departmentNo int not null,
							 foreign key(studentId) references student(studentId),
							 foreign key(departmentNo) references department(departmentNo)
							 );
							
Create table TinyHub.prof_hiredby (professorId int not null,
								   departmentNo int not null,
								   foreign key(professorId) references professor(professorId),
								   foreign key(departmentNo) references department(departmentNo)
								   );
									
Create table TinyHub.staff_hiredby (staffId int not null,
									departmentNo int not null,
									foreign key(staffId) references staff(staffId),
									foreign key(departmentNo) references department(departmentNo)
									);
									
Create table TinyHub.pursues (studentId int not null,
							  departmentNo int not null references majors(departmentNo),
							  programId int not null,
							  foreign key(studentId) references majors(studentId),
							  foreign key(departmentNo) references programs(departmentNo),
							  foreign key(programId) references programs(programId)
							  );
							
create table TinyHub.registers (studentId int not null,
								year_season varchar(100) not null,
								foreign key(studentId) references majors(studentId),
								foreign key(year_season) references semester(year_season)
								);
								
create table TinyHub.open_course (courseId int not null,
								  year_season varchar(100) not null,
								  professorId int not null,
								  capacity int not null,
								  foreign key(courseId) references courses(courseId),
								  foreign key(year_season) references semester(year_season),
								  foreign key(professorId) references professor(professorId),
								  primary key(courseId,year_season)
								  );
								
create table TinyHub.prerequisites (courseId int not null,
									prerequisite_id int DEFAULT 0,
									foreign key(courseId) references courses(courseId),
									foreign key(prerequisite_id) references courses(courseId)
									);
									
create table TinyHub.enrolls (studentId int not null,
							  grade char default 'N', 
							  check (grade in ('A','B','C','D','F')),
							  courseId int not null,
							  year_season varchar(100) not null,
							  foreign key(studentId) references student(studentId),
							  foreign key(year_season) references open_course(year_season),
							  foreign key(courseId) references open_course(courseId),
							  primary key(studentId, courseId, year_season)
							  );
								
create table TinyHub.TA (studentId int not null,
						 foreign key(studentId) references student(studentId)
						 );
						
Create table TinyHub.assists (studentId int not null,
							  year_season varchar(100) not null,
							  courseId int not null,
							  foreign key(studentId) references TA(studentId),
							  foreign key(year_season) references open_course(year_season),
							  foreign key(courseId) references open_course(courseId)
							  );
							
create table TinyHub.instructs (professorId int not null, 
								year_season varchar(100) not null,
								courseId int not null,
								foreign key(professorId) references prof_hiredby(professorId),
								foreign key(year_season) references open_course(year_season),
								foreign key(courseId) references open_course(courseId)
								);
								
create table TinyHub.feedback (studentId int not null,
							   professorId int not null, 
							   courseId int not null,
							   descriptions varchar(100),
							   foreign key(studentId) references enrolls(studentId),
							   foreign key(courseId) references enrolls(courseId),
							   foreign key(professorId) references instructs(professorId)
							   );
								
Create table TinyHub.programs_offers (programId int not null,
									  departmentNo int not null,
									  foreign key(programId) references programs(programId),
									  foreign key(departmentNo) references programs(departmentNo)
									  );
										
Create table TinyHub.courses_offers (courseId int not null,
									 departmentNo int not null,
									 foreign key(courseId) references courses(courseId),
									 foreign key(departmentNo) references courses(departmentNo)
									 );
									
Create table TinyHub.exam (examId int primary key,
						   courseId int not null,
						   cumulativeScore int not null,
						   grade char default 'N',
						   check (grade in ('A','B','C','D','F')),
						   foreign key(courseId) references courses(courseId)
						   );
							
Create table TinyHub.problems (problemId int primary key,
							   examId int not null,
							   score int not null,
							   foreign key(examId) references exam(examId)
							   );
								
Create table TinyHub.have_exams (examId int not null,
								 courseId int not null,
								 year_season varchar(100) not null,
								 foreign key(examId) references exam(examId),
								 foreign key(courseId) references open_course(courseId),
								 foreign key(year_season) references open_course(year_season)
								 );
								
Create table TinyHub.have_problems (examId int not null,
									problemId int not null,
									foreign key(examId) references problems(examId),
									foreign key(problemId) references problems(problemId)
									);

Create table TinyHub.gives_exams (examId int not null,
								  studentId int not null,
								  foreign key(examId) references exam(examId),
								  foreign key(studentId) references student(studentId)
								  );
								
Create table TinyHub.borrows_from (emailId varchar(100) not null,
								   borrowDate Date,
								   returnDate Date,
								   copiesBorrowed int,
								   extensionAvailable int,
								   constraint chk_date check(returnDate >= borrowDate 
								   							and datediff(returnDate, borrowDate) <= 21),
								   foreign key(emailId) references users(emailId)
								   );
									
Create table TinyHub.physical_sites (siteId int not null primary key,
									 siteName varchar(100) unique not null
									 );
									
Create table TinyHub.book (ISBN_No int not null primary key,
						   publicationDate date not null,
						   title varchar(100) not null,
						   no_of_Pages int not null
						   );
							
Create table TinyHub.author (authorId int not null primary key,
							 authorName varchar(100) not null
							 );
							
Create table TinyHub.copies (bookId int not null primary key,
							 purchaseDate Date not null,
							 price int not null
							 );
							
Create table TinyHub.has_no_dues (emailId varchar(100) not null,
								  bookId int not null,
								  foreign key(emailId) references borrows_from(emailId),
								  foreign key(bookId) references copies(bookId)
								  );
									
Create table TinyHub.located_at (ISBN_No int not null,
								 bookId int not null,
								 siteId int not null,
								 foreign key(ISBN_No) references book(ISBN_No),
								 foreign key(bookId) references copies(bookId),
								 foreign key(siteId) references physical_sites(siteId)
								 );
									
Create table TinyHub.book_has_copies (ISBN_No int not null,
									  bookId int not null,
									  foreign key(ISBN_No) references book(ISBN_No),
									  foreign key(bookId) references copies(bookId)
									  );
									
Create table TinyHub.written_by (ISBN_No int not null,
								 authorId int not null,
								 foreign key(ISBN_No) references book(ISBN_No),
								 foreign key(authorId) references author(authorId)
								 );