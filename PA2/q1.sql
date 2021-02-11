with employee1 as
(select a.emp_no, max(c.salary) as salary
from employees as a
join dept_emp as b on  a.emp_no = b.emp_no 
join salaries as c on a.emp_no = c.emp_no
where b.dept_no='d002' and year(a.birth_date) =1956 and a.emp_no < 100000
and b.to_date >= current_date() and c.to_date >= current_date()
group by a.emp_no)
  
select a.emp_no as e1 ,b.emp_no as e2 from employee1 a join employee1 b
where a.emp_no > b.emp_no and a.salary < b.salary
order by e1, e2;