with recursive film1 (film_id, total_earning1) as (select a.film_id, sum(d.amount) from film a
join inventory b on a.film_id = b.film_id
join rental c on b.inventory_id = c.inventory_id
join payment d on c.rental_id = d.rental_id group by a.film_id,d.amount),

film2 (film_id, total_earning) as (select film_id, sum(total_earning1) from film1
group by film_id),

film3 as (select a.film_id, (b.replacement_cost - a.total_earning) as to_breakeven from film2 a
join film b on a.film_id = b.film_id  group by film_id ),

film4 as(select film_id, to_breakeven from film3 a
where to_breakeven > 0
order by to_breakeven),

film5 as (select film_id, to_breakeven,(select count(*)+1 from film4 b where b.to_breakeven < a.to_breakeven)
as valuerank from film4 a
order by to_breakeven)

select film_id,to_breakeven from film5
where valuerank in (6,7,8,9,10)
order by film_id