

use sakila;
select title 
from film
where film_id=1;

use sakila;
select title, language.name as language
from film
join language using (language_id)
where film_id=1;

-- query the same but with a subquery
-- ususally the subquery is faster than the join query, not in this case, and not always!!
use sakila;
select title, (select name from language where language_id=film.language_id) as language
from film
where film_id=1;



-- query all the custmers who have rented action movies

use sakila;
select distinct customer.first_name, customer.last_name
from customer
join rental using (customer_id)
join inventory using (inventory_id)
join film_category using (film_id)
-- we don't need to join the film table, because we don't need any data from it
-- join film using (film_id)
join category using (category_id)
where category.name='Action'
order by first_name, last_name;

-- do the same with subqueries
-- query all the custmers who have rented action movies
use sakila;
select distinct customer.first_name, customer.last_name
from customer
where customer.customer_id in (
    select rental.customer_id
    from rental
    where rental.inventory_id in (
      select inventory.inventory_id
      from inventory where inventory.film_id in (
        select film_category.film_id
        from film_category
        where film_category.category_id in (
          select category.category_id
          from category
          where category.name='Action'
      )
    )
  )
);

