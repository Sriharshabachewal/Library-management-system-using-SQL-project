SELECT * from books;
SELECT * from branch;
SELECT * from employees;
SELECT * from issued_status;
SELECT * from return_status;
SELECT * from members;


-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT into books(isbn,book_title,category,rental_price,status,author,publisher)
values('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')
;
SELECT * from books;

--Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '457 Elm st'
WHERE member_id = 'C102';
SELECT * from members;

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE from issued_status
where issued_id = 'IS121';
SELECT * FROM issued_status;

--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * from issued_status
WHERE issued_emp_id = 'E101';

--Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_emp_id,
       count(*) 
from issued_status
group by 1
having count(*) > 1;

--CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

CREATE table book_cnts
AS
SELECT b.isbn,b.book_title,count(ist.issued_id) as issue_count
from issued_status as ist
join books b
on ist.issued_book_isbn = b.isbn
group by b.isbn,b.book_title;

SELECT  * from book_cnts;

--Task 7. Retrieve All Books in a Specific Category:
SELECT * from books
where category = 'Fiction';

--Task 8: Find Total Rental Income by Category:
SELECT b.category,
       SUM(b.rental_price),
	   COunt(*)
from issued_status as ist
join books b
on ist.issued_book_isbn = b.isbn
group by 1;

-- TASK 9:List Members Who Registered in the Last 180 Days:
SELECT * from members
where reg_date >= current_date - interval '180 days'

-- TASK 10: List Employees with Their Branch Manager's Name and their branch details:
SELECT 
      e1.*,
	  b.manager_id,
	  e2.emp_name as manager
from employees  as e1
join
branch as b
on b.branch_id = e1.branch_id
join
employees as e2
on b.manager_id = e2.emp_id;

-- TASK 11: Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE table book_rental_price
as
select * from books
where rental_price > 7;

select * from book_rental_price;

-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT 
      DISTINCT ist.issued_book_name
from issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
where rs.return_id IS NULL;



