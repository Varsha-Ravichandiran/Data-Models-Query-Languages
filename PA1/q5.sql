select a.dept_name,count(b.emp_no) as noe from departments as a
join dept_emp as b using(dept_no)
join employees as c using(emp_no)
where b.to_date >= current_date()
group by a.dept_name
having noe > 20000
order by a.dept_name;