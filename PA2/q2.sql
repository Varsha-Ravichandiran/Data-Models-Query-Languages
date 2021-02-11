select c.dept_name, b.title, count(b.emp_no) as cnt from dept_emp as a
join departments as c on a.dept_no = c.dept_no
join titles as b on a.emp_no = b.emp_no
where b.to_date > current_date() and a.to_date > current_date()
group by b.title, a.dept_no
order by c.dept_name, b.title;