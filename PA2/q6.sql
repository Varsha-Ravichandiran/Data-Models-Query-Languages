with employee7 as
(select a.emp_no, a.salary
from salaries as a 
where a.emp_no < 20000 and a.to_date >= current_date()),

employee8 as 
(select a.emp_no, a.salary, (select(select count(*) from employee7) - count(*) from employee7 b where a.salary < b.salary)
as rank1 from employee7 as a
order by a.salary desc)

select a.emp_no, (100 * (((a.rank1) - 1)/((select count(*) from employee8) - 1))) as percentile from employee8 as a
order by a.emp_no