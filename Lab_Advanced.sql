-- DONE: LAB Advanced Queries

use sakila;

-- List each pair of actors that have worked together.

select * from film_actor;

select fa1.actor_id as actor1, fa2.actor_id as actor2, film_id 
from film_actor fa1
	join film_actor fa2 using(film_id)
	where fa1.actor_id <> fa2.actor_id
	order by actor1;

#2. For each film, list actor that has acted in more films.

create or replace view no_of_films_per_actor as
select film_id, actor_id, row_number() over(partition by film_id) as ranking
from actor join film_actor using(actor_id);

select * from no_of_films_per_actor;

select count(film_id),actor_id,ranking from no_of_films_per_actor
group by actor_id
having ranking = 1
order by count(film_id) desc;