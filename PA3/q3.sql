with recursive cte3 as
((select 1 as m, 1 as n, 1*1 as k
union all
select m, n+1, m*(n+1) 
from cte3 where n < 9)
union all
(select m+1, n, (m+1)*n
from cte3
where m < 9))

select distinct m, n, k as 'm*n' from cte3;