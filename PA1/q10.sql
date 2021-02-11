select a.title as film_1, b.title as film_2, a.length, a.rating from film as a
inner join film as b on a.length = b.length
and a.rating = b.rating
and a.title > b.title