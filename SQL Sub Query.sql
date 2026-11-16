
-- SUB Queries

-- Find the products that have a price higer than the avg price of all products.

select
*
from(
	select
		productid,
		price,
		avg(price) OVER() AVGPrice
	from sales.Products
) t
where price > AVGPrice


-- Rank Customers based on their total amount of sales

select *,
rank() OVER(Order by totalSales desc) CustomerRank
from (
	select
	customerid,
	sum(sales) totalSales
	from Sales.Orders
	group by CustomerID
)tt


-- Show the product IDs, names, prices and totatl no. of orders.

select 
	ProductID, 
	product,
	price,
	(select count(*) from Sales.Orders) Totalorders
from sales.products


-- Show all customer details and find the total orders of each customer.


select * from Sales.Customers a left join 
(
	select CustomerID, count(*) totalOrders
	from Sales.Orders group by CustomerID
) b
on a.CustomerID=b.CustomerID


-- Find the products that have a price higher than the 
-- average price of all products

select *, (select avg(price) from sales.Products) AVGProduct
from sales.Products
where Price > (
	select avg(price) from sales.Products
)


