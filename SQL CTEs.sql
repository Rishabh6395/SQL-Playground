

-- Step1: Find the total Sales Per Customers.
-- Step2: Find the last order date for each customer

with cte_total_Sales as (
	select 
		CustomerID, sum(sales) TotalSales
	from Sales.Orders
	group by CustomerID
),
cte_last_order as (
	select 
		customerid,
		max(orderdate) as Last_Order
	from Sales.Orders group by CustomerID
)
select 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.TotalSales,
	clo.Last_Order
from 
Sales.Customers c
left join cte_total_Sales cts
on c.CustomerID=cts.CustomerID
left join cte_last_order clo
on c.CustomerID=clo.CustomerID
order by CustomerID

