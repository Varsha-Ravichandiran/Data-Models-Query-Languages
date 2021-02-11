select b.dept_name, count(*) as cnt from dept_manager as a
join departments as b on a.dept_no = b.dept_no
where a.to_date < current_date()
group by a.dept_no
having cnt > 1
order by b.dept_name;