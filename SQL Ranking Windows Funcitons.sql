
-- Rank the order based on their sales from highest to lowest

SELECT
	Orderid,
	Productid,
	sales,
	ROW_NUMBER() over (order by sales desc) salesRank_Row,
	RANK() over (order by sales desc) salesRank
from Sales.Orders


