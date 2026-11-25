
-- NON-RECURSIVE CTE: is exected only once without any repetition.:

-- 1. multiple CTEs: we can use multiple CTEs using (,) to serprate them:

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




-- 2. Nested CTE: We can use the first CTE into another 2nd CTE. Please refer the below example:

-- Step1: Find the total Sales Per Customers.
-- Step2: Find the last order date for each customer
-- Step3: Rank Customers based on total sales per customer.
-- Step4: Segment customers based on their total sales (Nested CTE)

-- Step1: Find the total Sales Per Customers.
with cte_total_Sales as (
	select 
		CustomerID, sum(sales) TotalSales
	from Sales.Orders
	group by CustomerID
),
-- Step2: Find the last order date for each customer
cte_last_order as (
	select 
		customerid,
		max(orderdate) as Last_Order
	from Sales.Orders group by CustomerID
),
-- Step3: Rank Customers based on total sales per customer.
cte_Customer_rank as
(
	select
		customerid,
		TotalSales,
		rank() over (order by totalsales desc) as customerRank
	from cte_total_Sales
),
-- Step4: Segment customers based on their total sales (Nested CTE)
CTE_customer_segments As
(
	select
		customerid,
		totalsales,
	case when totalsales > 100 Then 'High'
		when totalsales > 80 then 'Medium'
		else 'Low'
	end customerSegment
	from cte_total_Sales
)
-- Main Query
select 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cts.TotalSales,
	clo.Last_Order,
	ccr.customerRank,
	ccs.customerSegment
from 
Sales.Customers c
left join cte_total_Sales cts
on c.CustomerID=cts.CustomerID
left join cte_last_order clo
on c.CustomerID=clo.CustomerID
left join cte_Customer_rank ccr
on ccr.CustomerID=c.CustomerID
left join CTE_customer_segments ccs
on ccs.CustomerID=c.CustomerID
order by CustomerID


-- Recursive CTE: Self-referencing query that repeatdly processes data until a specific condition is met.






