

-- Inner JOIN -> Returns only Matching Rows from both tables
-- Without mentioning the type of JOIN, SQL by default setting as INNER JOIN if we are not mentioning the type


select cust.id, cust.first_name, cust.score, ord.sales
from customers as cust inner join orders as ord
on cust.id=ord.customer_id 


-- LEFT JOIN -> return all rows from left table and only matching form right table

-- Question -> Get all customers along with their orders, including those without orders.

select cust.id, cust.first_name, cust.score, ord.sales, ord.order_id
from customers as cust
left join orders as ord on cust.id=ord.customer_id


-- RIGHT JOIN -> Returns all Rows from Right and only Matching from Left
/*
 Question -> Get all customers along with their orders,
including orders without matching customers.
*/

select * from customers as cust RIGHT JOIN 
orders as ord on cust.id=ord.customer_id


/*
	FULL JOIN -> Returns all rows from Both Tables

	Quesetion -> Get all customers and all orders, even if there's no match.
*/

select cust.id, cust.first_name, cust.score, ord.sales, ord.order_id
from customers as cust
FULL join orders as ord on cust.id=ord.customer_id
