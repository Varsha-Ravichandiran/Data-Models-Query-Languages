select a.emp_no, c.dept_name from dept_manager a
join departments c on a.dept_no = c.dept_no
where datediff(a.to_date,a.from_date) <= all(select datediff(b.to_date,b.from_date) from
dept_manager b where a.dept_no = b.dept_no)
order by a.emp_no;