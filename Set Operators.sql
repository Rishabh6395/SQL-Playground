-- SQL SET OPERATORS
-- UNION: Returns alll distinct rows from both queries. Removes duplicates rows from the result.

-- Combine the data from employees and customers into one table
Select 
firstname,
lastname
from Sales.Customers

union

select 
firstname,
lastname
from Sales.Employees


-- UNION ALL: Returns all rows from both queries, including duplicates

Select 
firstname,
lastname
from Sales.Customers

union all

select 
firstname,
lastname
from Sales.Employees


-- EXCEPT: Returns all distinct rows from the first query that are not found in the second query.
-- it is the only one where the order of queries affects the final result.

-- Find the employees who are not customers at the same time.
Select 
firstname,
lastname
from Sales.Employees

except

select 
firstname,
lastname
from Sales.Customers


-- INTERSECT
-- Returns Common rows between two tables.

Select 
firstname,
lastname
from Sales.Employees
INTERSECT
select 
firstname,
lastname
from Sales.Customers


-- Orders data are stored n separte tables (Order and OrdersArchive)
-- Combine all orders data into one report without duplicates.
Select 
'Orders' as sourcetable,
[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.Orders
UNION
select
'OrdersArchive' as sourcetable,
[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from Sales.OrdersArchive
order by OrderID asc;
