select a.film_id, c.length, a.avg_days from (select a.film_id, avg(datediff(b.return_date,b.rental_date)) as avg_days from inventory as a 
join rental as b on a.inventory_id = b.inventory_id
group by a.film_id) as a
join film as c on a.film_id = c.film_id
order by a.film_id;