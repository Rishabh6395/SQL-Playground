
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



select 
ROW_NUMBER() OVER (Order by orderid, orderdate) UniqueID,
* 
from sales.OrdersArchive



-- Identify duplicate rows in the table 'Orders Archive'
-- and return a clean result without any duplicates

select * from (
select 
ROW_NUMBER() OVER(Partition by Orderid order by creationtime desc) rn,
*
from sales.OrdersArchive
) t where rn=1


-- NTITLE()
-- Divides the rows into a specified number of approximately equal groups (Buckets)


Select
Orderid,
Sales,
NTILE(3) Over(Order by sales desc) threeBucket,
NTILE(2) Over(Order by sales desc) twoBucket,
NTILE(1) Over(Order by sales desc) oneBucket
from sales.Orders




-- Segment all orders into 3 categories: high, medium and low sales.

select * ,
	case 
		when bucket =1  Then 'High'
		when bucket = 2 then 'medium'
		when bucket = 3 then 'low'
	END AS Sales_Category
from (
	select
		orderid,
		Sales,
		NTILE(3) OVER(ORDER BY Sales desc) Bucket
	from Sales.Orders
) t

