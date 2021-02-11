select a.customer_id, sum(c.amount) as total, count(b.rental_id) as n_rent from customer as a
join rental as b on a.customer_id = b.customer_id
join payment as c on b.rental_id = c.rental_id
group by a.customer_id
having total > 100
order by a.customer_id;