
-- LAG() -> if we are standing on March month and if 
-- we want value from prevous Feb month then we use LAG()


-- LEAD() -> if we are standing on March month and if 
-- we want value from next April month then we use LEAD()


-- FIRST_VALUE() -> If we want value first of the table
-- like Jan data then we use FIRST_VALUE()

-- LAST_VALUE() -> If we want value LAST of the table
-- like Dec data then we use LAST_VALUE()


-- Value Functions Syntax
-- Order by is requeired for all value functions

-- LEAD(expression, offset, default Value) 
-- LAG(expression, offset, default Value)
-- FIRST_VALUE(expression)
-- LAST_VALUE(expression)


-- TASK

-- Analyze the month-over-month performance
-- by finding the percentage change in sales
-- between the current and previous month

SELECT
*,
currentMonthSales - PrevMonthSales as MOM_Change,
ROUND(CAST((currentMonthSales - PrevMonthSales )As Float) / PrevMonthSales * 100 ,1 ) as MOM_PERC
from (
	SELECT 
		MONTH(OrderDate) orderMonth,
		SUM(Sales) CurrentMonthSales,
		LAG(SUM(sales)) OVER (ORDER BY MONTH(orderDate)) PrevMonthSales
	from Sales.Orders
	group by 
		MONTH(orderDate)
) t


-- In order to analyze customer loyalty,
-- rank customers based on the avg days between their orders.

select
customerId,
AVG(Daysuntilnextorder) AVGDays,
RANK() Over (Order by Coalesce(AVG(Daysuntilnextorder), 9999)) RankAvg
from (
	select 
		orderid,
		customerid,
		orderdate currentOrder,
		LEAD(OrderDate) OVER (Partition by customerID order by orderDate) NextOrder,
		DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER (Partition by customerID order by orderDate)) DaysUntilNextOrder
	from Sales.Orders 
) t
group by 
	CustomerID


	