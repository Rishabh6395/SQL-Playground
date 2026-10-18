
use SalesDB


select * from sales.Orders

-- Find the total num of orders for each product

select 
	orderid, sales, productid,
	count(*) over (Partition by Productid) countofeachProduct
from sales.Orders

-- Find the tottal number of Order for each Customers.

select 
	orderid, sales, productid, customerid,
	count(*) over (Partition by Productid) countofeachProduct,
	count(*) over (partition by customerid) totalOrderByCustomer
from sales.Orders


-- Find the total number of scores for the customers.

select top 10 * from sales.Customers

select *, count(score) over () totalCustomers 
from sales.Customers


select count(*) over(Partition by orderid) as orderPK
from Sales.Orders


select * from (
select orderid,
count(*) over(Partition by orderid) as orderPK
from Sales.OrdersArchive
) t where orderPK > 1

