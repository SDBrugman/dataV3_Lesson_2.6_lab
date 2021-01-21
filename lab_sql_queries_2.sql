Use sakila;

-- 1 --
SELECT film_id, title, release_year
FROM film;

-- 2 --
SELECT film_id, title
FROM film
WHERE title LIKE '%ARMAGEDDON%';

-- 3 --
SELECT film_id, title
FROM film
WHERE title REGEXP 'APOLLO$';

-- 4 --
SELECT film_id, title, length AS LongestFilms
FROM film
ORDER BY length DESC
LIMIT 10;

-- 5 --
SELECT * from film;

SELECT COUNT(special_features) AS BehindTheScenesFilms
FROM film
WHERE special_features in ('Behind the Scenes'); 

-- 6 --
alter table staff
drop column picture;

-- 7 --
SELECT * from customer where first_name = 'TAMMY' and last_name = 'SANDERS';
SELECT * from staff;
 
insert into staff (staff_id,first_name,last_name,address_id,email,store_id,active,username)
-- staff_id,first_name,last_name,address_id,email,store_id,active, username
values (3, 'Tammy', 'Sanders', 79, 'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy');

-- 8 --
SELECT customer_id, first_name, last_name, store_id
FROM customer
WHERE first_name = 'Charlotte' and last_name = 'Hunter'; # customer_id = 130

SELECT film_id, title
FROM film
WHERE title = 'Academy Dinosaur'; # film_id = 1

SELECT staff_id, first_name, last_name
FROM staff
WHERE first_name = 'Mike' and last_name = 'Hillyer'; # staff_id = 1

SELECT inventory_id, film_id, store_id
FROM inventory
WHERE film_id  = 1 AND store_id = 1;

SELECT * 
FROM rental;

select DISTINCT(rental_id), customer_id
from rental
order by rental_id desc
limit 1;

insert into rental (rental_id, rental_date, inventory_id, customer_id, staff_id)
values (16050,'2021-01-20',1,130,1);

-- 9 -- 
SELECT customer_id, email, active
FROM customer
WHERE active = 0;

drop table if exists deleted_users;

CREATE TABLE deleted_users (
	customer_id int(11) UNIQUE NOT NULL,
    email varchar(50) DEFAULT NULL,
    date int(11)
    #constraint foreign key(customer_id) references customer(customer_id)
); 

alter table deleted_users
modify date date;

insert into deleted_users (customer_id,email,date)
VALUES
(16,'SANDRA.MARTIN@sakilacustomer.org','2021-01-20'), 
(64,'JUDITH.COX@sakilacustomer.org','2021-01-20'), 
(124,'SHEILA.WELLS@sakilacustomer.org','2021-01-20'), 
(169,'ERICA.MATTHEWS@sakilacustomer.org','2021-01-20'), 
(241,'HEIDI.LARSON@sakilacustomer.org','2021-01-20'),
(271,'PENNY.NEAL@sakilacustomer.org','2021-01-20'),
(315,'KENNETH.GOODEN@sakilacustomer.org','2021-01-20'),
(368,'HARRY.ARCE@sakilacustomer.org','2021-01-20'),
(406,'NATHAN.RUNYON@sakilacustomer.org','2021-01-20'),
(446,'THEODORE.CULP@sakilacustomer.org','2021-01-20'),
(482,'MAURICE.CRAWLEY@sakilacustomer.org','2021-01-20'),
(510,'BEN.EASTER@sakilacustomer.org','2021-01-20'),
(534,'CHRISTIAN.JUNG@sakilacustomer.org','2021-01-20'),
(558,'JIMMIE.EGGLESTON@sakilacustomer.org','2021-01-20'),
(592,'TERRANCE.ROUSH@sakilacustomer.org','2021-01-20');

SELECT *
FROM deleted_users;

SELECT customer_id, active
FROM customer
WHERE active = 0;

/*Run this code before deleting - the problem was that other tables were using the cistomer_id as foreign key
so we needed to allow deleting that'*/

alter table payment add CONSTRAINT `f_payment_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE;
alter table rental add CONSTRAINT `f_rental_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE;

#DELETE FROM customer WHERE active = 0; -- gives error using safe update mode
DELETE FROM customer 
WHERE (customer_id) IN (16,64,124,169,241,271,315,368,406,446,482,510,534,558,592);