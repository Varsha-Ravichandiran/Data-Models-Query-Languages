with recursive cte1 as 
(select src, dst from amap where src in (select distinct src from amap)
union
select cte1.src, amap.dst from amap, cte1 where cte1.dst = amap.src) 

select * from cte1 order by src, dst;