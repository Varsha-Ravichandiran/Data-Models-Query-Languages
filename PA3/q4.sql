with recursive employee1(src, dst, year, temp) as 
(select a.title as src, b.title as dst, avg(year(a.to_date) - year(a.from_date)) + 1 as year , 0
from titles as a, titles as b
where a.title <> b.title and a.emp_no = b.emp_no and a.to_date = b.from_date
group by src, dst
union 
select employee1.src, c.dst , employee1.year + c.year as year, employee1.temp+1 as temp from 
(select a.title as src, b.title as dst, avg(year(a.to_date) - year(a.from_date)) + 1 as year
from titles as a, titles as b
where a.title <> b.title and a.emp_no = b.emp_no and a.to_date = b.from_date
group by src, dst) as c , employee1 where employee1.dst = c.src and employee1.temp < 3)

select src, dst, min(year) as years from employee1 where src <> dst group by src, dst
order by src, dst;