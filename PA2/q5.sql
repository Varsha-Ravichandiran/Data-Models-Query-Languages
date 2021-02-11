with employee2 as
(select a.emp_no as emp_no, a.title as o_title, b.title as n_title, a.from_date, b.from_date as o_date from titles a
join titles b
where a.to_date = b.from_date and a.emp_no = b.emp_no) 

select a.emp_no, a.o_date as on_date, a.o_title, a.n_title, s1.salary as o_salary, s2.salary as n_salary from salaries s1
join salaries s2  on s1.emp_no = s2.emp_no and s1.to_date = s2.from_date and s1.salary > s2.salary 
join employee2 as a on a.o_date = s1.to_date and a.emp_no = s1.emp_no