with actor1 as
(select a.actor_id, count(distinct b.category_id) as ncat from film_actor as a
join film_category as b on a.film_id = b.film_id
group by a.actor_id)

select concat_ws(' ',a.first_name,a.last_name) as actor_name, b.ncat from actor as a
join actor1 as b on a.actor_id = b.actor_id
group by actor_name
order by actor_name;