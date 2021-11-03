/*
1. Find out the number of documentaries with deleted scenes.
2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens.
3. Find out the total sales from Animation movies.
4. Find out the top 3 rented category of movies by “PATRICIA JOHNSON”.
5. Find out the number of R rated movies rented by “SUSAN WILSON”.


*/

-- 1. Find out the number of documentaries with deleted scenes.
select count(*) as number_of_documentaries_with_deleted_scenes from
category inner join film_category
on category.category_id=film_category.category_id
inner join film
on film_category.film_id=film.film_id
where category.name='Documentary' and special_features like '%Deleted Scenes%'

-- 2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens.
select count(distinct film_category.film_id)
from
rental inner join inventory
on rental.inventory_id=inventory.inventory_id
inner join staff
on rental.staff_id=staff.staff_id
inner join film_category
on film_category.film_id=inventory.film_id
inner join category
on film_category.category_id=category.category_id
where staff.first_name='Jon' and staff.last_name='Stephens' and category.name='Sci-Fi'

-- 3. Find out the total sales from Animation movies.
select count(distinct rental_id) as total_sales_from_animated_movies
from
rental inner join inventory
on rental.inventory_id=inventory.inventory_id
inner join film_category
on inventory.film_id=film_category.film_id
inner join category
on film_category.category_id=category.category_id
where category.name='Animation'

-- 4. Find out the top 3 rented category of movies by “PATRICIA JOHNSON”.
select category.name, count(*)
from 
rental inner join customer
on rental.customer_id=customer.customer_id
inner join inventory
on rental.inventory_id=inventory.inventory_id
inner join film_category 
on inventory.film_id=film_category.film_id
inner join category
on film_category.category_id=category.category_id
where customer.first_name='PATRICIA' and customer.last_name='JOHNSON'
group by category.name
order by count(*) desc
limit 3

-- 5. Find out the number of R rated movies rented by “SUSAN WILSON”.
select count(film.film_id) as number_of_R_rated_movies_by_SUSAN_WILSON
from 
rental inner join customer
on rental.customer_id=customer.customer_id
inner join inventory
on rental.inventory_id=inventory.inventory_id
inner join film 
on inventory.film_id=film.film_id
where customer.first_name='SUSAN' and customer.last_name='WILSON' and film.rating='R'
