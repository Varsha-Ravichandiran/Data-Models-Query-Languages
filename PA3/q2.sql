with recursive cte2 as
(select 0 as n, 0 as d1, 0 as d
union all
select n+1, d,
case when (n+1) > 1 and mod(d,2) = 0 then d + d1 + 1
	 when (n+1) > 1 and mod(d,2) <> 0 then d + d1
	 else n+1
end
from cte2
where (d+d1) < 100)

select n, d as 'f(n)' from cte2;