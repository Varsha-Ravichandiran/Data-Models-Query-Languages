select a.rental_id,b.payment_id from rental as a
join payment as b on a.rental_id  = b.rental_id
where b.amount = any (select min(amount) from payment) 
order by rental_id;