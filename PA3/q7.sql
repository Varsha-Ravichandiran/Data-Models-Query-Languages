with recursive flight2(src, dst, cost, temp) as 
(select a.src as src, a.dst as dst, a.cost as cost , 0
from amap as a, amap as b
where a.src <> b.src
group by src, dst
union 
select flight2.src, c.dst , flight2.cost + c.cost as cost, flight2.temp+1 temp from 
(select a.src as src, a.dst as dst, a.cost as cost from amap as a, amap as b
where a.src <> b.src
group by src, dst) as c , flight2 where flight2.dst = c.src and flight2.temp < 1)

select src, dst, min(cost) as cost from flight2 where src <> dst group by src, dst
order by src, dst;