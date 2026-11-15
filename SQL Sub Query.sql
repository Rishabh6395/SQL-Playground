
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




