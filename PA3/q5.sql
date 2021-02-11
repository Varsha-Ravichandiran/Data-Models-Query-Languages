with recursive s1 as 
(select b.customer_id, a.location from address as a
join customer as b on a.address_id = b.address_id),

s2 as
(select a1.customer_id as c1 , a2.customer_id as c2, ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192,2) as distance from s1 as a1, s1 as a2
where a1.customer_id <> a2.customer_id and a1.customer_id < a2.customer_id and -180 < ST_X(a1.location) and ST_X(a1.location) <= 180 and
ST_Y(a1.location) <= 90 and -180 < ST_X(a2.location) and ST_X(a2.location) <= 180 and
ST_Y(a2.location) <= 90 having distance between 1 and 20),

s3 as
(select a.c1 , b.c2, (a.distance + b.distance) as distance from s2 a, s2 b
where b.c1 = a.c2
union
select * from s2
order by c1,c2)

select c1, c2, min(distance) as distance from s3 where c1 not in(select c2 from s3) group by c1,c2 