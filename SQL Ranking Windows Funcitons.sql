
-- Rank the order based on their sales from highest to lowest
use SalesDB



SELECT
	Orderid,
	Productid,
	sales,
	ROW_NUMBER() over (order by sales desc) salesRank_Row,
	RANK() over (order by sales desc) salesRank
from Sales.Orders


SELECT
	Orderid,
	Productid,
	sales,
	ROW_NUMBER() over (order by sales desc) salesRank_Row, -- working based on row number.
	RANK() over (order by sales desc) salesRank, -- working based on row number.
	DENSE_RANK() over(order by sales desc) salesRank_Dense -- skips/gaps
from Sales.Orders


-- Find the top highest sales for each product
select * from (
select
	orderid,
	productid,
	sales,
	ROW_NUMBER() Over(partition by productid order by sales desc) rankByproduct
from Sales.Orders
) t where t.rankByproduct = 1

-- Find the lowest 2 customers based on their total sales
select * from (
select 
	customerid,
	Sum(sales) totalSales,
	ROW_NUMBER() over (order by sum(sales)) rankCustomer
from Sales.Orders
group by customerid
) t where t.rankCustomer <= 2;










