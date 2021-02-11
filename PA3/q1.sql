with recursive cte1 as
(select 999 as n, 1 as d, 999/1 as q
union all
select n, d+1, n/(d+1)
from cte1
where d < 999)

select * from cte1
where mod(n,d)=0;