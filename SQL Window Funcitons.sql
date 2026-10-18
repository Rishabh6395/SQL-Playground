
-- Find the total sales for each Product:

use SalesDB

select * from sales.Orders

select ProductID, sum(sales) as TotalSales from sales.Orders
group by ProductID


-- Find the total sales for each product, 
-- additionally provide details such order id & order date;

/*
select OrderID, OrderDate, ProductID, sum(sales) as TotalSales  from sales.Orders
group by ProductID, OrderID, OrderDate -- Not Getting the TotalSales for each Product. */
/*
	NOTE: 1. By adding OVER() SQL understand we are talking about Window Function now.
		  2. PARTITION BY: Here we define a column where the partion/Groups is created just like
		  we did in the below query. We devided the sum of total sales by grouping by ProductID.
		  So for each productID seprate groups is created.
		  For simplicity: Divides rows into separate groups based on a column, similar to GROUP BY, 
		  but does not combine rows into one row per group.
		  3. SUM(Sales) OVER(PARTITION BY ProductID) — Calculates the total sales for each product and 
		  displays that same total alongside every row belonging to that product.
		  4. Difference between GROUP BY and window functions:
- GROUP BY ProductID → Returns one row per product.
- SUM(Sales) OVER(PARTITION BY ProductID) → Keeps all original rows and adds the total sales for each product.
*/
select 
	OrderID,
	OrderDate,
	ProductID,
	sum(sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
from sales.Orders 



-- Find the total sales across all order
-- Additionally provide details such order Id, Order Date


select 
orderId,
orderdate,
SUM(Sales) OVER() TotalSales
from sales.Orders


-- Find the total sales for each product
-- Additionally provide details such order Id, Order Date


select 
orderId,
orderdate, productid,
SUM(Sales) OVER(PARTITION BY productid) TotalSales
from sales.Orders


-- Find the total sales across all orders,
-- Find the total sales for each product
-- Find the total sales for each combination of product and order status
-- Additionally provide details such order Id, Order Date


select 
orderId,
orderdate, productid, Orderstatus, sales,
SUM(Sales) OVER() TotalSales,
SUM(Sales) OVER(PARTITION BY productid) SalesByProducts,
SUM(Sales) OVER(PARTITION BY productid, orderStatus) SalesByProductsAndStatus
from sales.Orders





-- Rank each order based on their sales from Highest to Lowest,
-- Additionally provide details such order id & order date.


select
	orderid,
	orderdate,
	sales, RANK() OVER(ORDER BY Sales DESC) RankSales
from sales.Orders

