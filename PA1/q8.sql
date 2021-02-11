update customer
set active = 0
where first_name = 'MARIA' and last_name = 'MILLER';

select email, active from customer 
where first_name = 'MARIA' and last_name = 'MILLER';