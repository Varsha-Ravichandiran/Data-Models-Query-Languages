select a.emp_no as emp,b.emp_no as mgr,a.from_date from dept_emp as a
join dept_manager as b on a.dept_no = b.dept_no
and b.to_date > current_date() and a.to_date > current_date()
order by a.emp_no;