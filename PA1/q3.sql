select a.last_name,b.salary,b.from_date,b.to_date from employees as a
join salaries as b using(emp_no)
order by a.last_name, b.from_date, b.to_date, b.salary;