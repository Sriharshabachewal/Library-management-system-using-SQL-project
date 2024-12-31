-- LIBRARY MANAGEMENT SYSTEM PROJECT
-- CREATING A BRANCH TABLE
CREATE table branch(branch_id varchar(10) primary key,
                    manager_id varchar(10), 
					branch_address varchar(55), 
					contact_no varchar(10)
					);

ALTER table branch
ALTER column contact_no type varchar(25);

DROP table if exists employees;
CREATE table employees(emp_id varchar(10) primary key, 
                       emp_name varchar(25), 
					   position varchar(20), 
					   salary int, 
					   branch_id varchar(20)
					   );

DROP table if exists books;
CREATE table books(isbn varchar(25) primary key,
                   book_title varchar(75), 
				   category varchar(20), 
				   rental_price float, 
				   status varchar(20),
				   author varchar(35),
				   publisher varchar(55)
				   );

ALTER table books
ALTER column category type varchar(25);

DROP TABLE IF EXISTS members;
CREATE table members(member_id varchar(10) primary key,
                     member_name varchar(35),
					 member_address varchar(75),
					 reg_date DATE);


CREATE table issued_status(issued_id varchar(10) primary key,
                           issued_member_id varchar(25),
						   issued_book_name varchar(75), 
						   issued_date DATE, 
						   issued_book_isbn varchar(35), 
						   issued_emp_id varchar(25)
						   );

CREATE table return_status(return_id varchar(10) primary key,
                           issued_id varchar(10), 
						   return_book_name varchar(10),
						   return_date DATE,
						   return_book_isbn varchar(35)
						   );

-- FOREIGN KEY

ALTER table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);

ALTER table issued_status
add constraint fk_books
foreign key (issued_book_isbn)
references books(isbn);

ALTER table issued_status
add constraint fk_employees
foreign key (issued_emp_id)
references employees(emp_id);

ALTER table employees
add constraint fk_branch
foreign key (branch_id)
references branch(branch_id);

ALTER table return_status
add constraint fk_issued_status
foreign key (issued_id)
references issued_status(issued_id);

