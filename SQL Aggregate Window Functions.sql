
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



select * from Sales.Orders

select sales,orderstatus, sum(sales)
	over(partition by orderstatus) totalSales
from Sales.Orders

-- Find the total sales across all orders and the totalsales for each product.
-- Additionallly, provide details such as orderID and order date.

select 
	sales,
	orderid,
	orderdate,
	productid,
	sum(sales) over() totalSales,
	sum(sales) over(partition by productid) totalSalesAcrossProducts
from Sales.Orders


-- Find the percentage contribution of each product's sales to the total sales.

select
	orderid,
	productid,
	sales,
	sum(Sales) over() totalSales,
	Round(cast(sales as float) / sum(Sales) over()  * 100, 2) percentageOftotal
from Sales.Orders


-- Find the average sales across alll orders
-- And find the average sales for each product
-- Additionally provide details such order Id, order Date

select 
	orderid,
	orderdate,
	sales,
	avg(sales) over() avgsales,
	avg(sales) over (partition by productid) avgSalesByProducts
from sales.Orders


use SalesDB

-- Find all orders where sales are higher than the average sales across all orders

select 
*
 from (
select 
	OrderID,
	ProductID,
	Sales,
	AVG(Sales) Over () avgsales
from Sales.Orders
) t where sales > avgsales



-- Find the highest & lowest sales across all orders and the highest & lowset sales for each
-- product. Additionally, provide details such as order ID and order date.


select 
	OrderID,
	OrderDate,
	orderstatus,
	productid,
	sales,
	max(sales) over() HighestSales,
	min(sales) over() LowestSales,
	max(sales) over(partition by  productid) HighestSalesbyProduct,
	min(sales) over(partition by  productid) LowestSalesbyProduct
from sales.Orders


-- Show the emps with the highest salaries.

select * from (
	select *,
		max(salary) Over () HighestSalary
	from Sales.Employees
) t where Salary = HighestSalary



-- RUNNING TOTAL

-- Calculate moving average of sales for each product over time

select
	Orderid,
	productid,
	orderdate,
	sales,
	avg(sales) Over(partition by productid) avgByProduct,
	avg(sales) Over(partition by productid order by orderdate) movingavg
from Sales.Orders

-- ROLLING TOTAL

-- Calculate moving average of sales for each product over time
-- Calculate moving avg of sales for each product over time, including only the next order.

select
	Orderid,
	productid,
	orderdate,
	sales,
	avg(sales) Over(partition by productid) avgByProduct,
	avg(sales) Over(partition by productid order by orderdate) movingavg,
	avg(sales) Over(partition by productid order by orderdate Rows between current row and 1 following) movingavg
from Sales.Orders
