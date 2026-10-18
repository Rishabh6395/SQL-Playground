

use SalesDB


select category,
sum(sales) as totalSales from (
	select  orderid, sales,
		case 
			when sales >= 90 then 'High'
			when sales >= 50 then 'High medium'
			when sales >= 20 then 'Low'
			else 'Very low'
		end category
		from sales.Orders 
)t
group by category
order by totalSales desc;


select * from sales.Employees

select employeeid, firstname, gender,
case 
	when gender = 'M' then 'Male'
	when gender = 'F' then 'Female'

	else 'NA'
end,
case gender
	when  'M' then 'Male'
	when  'F' then 'Female'
	else 'NA'
	end 
from sales.employees
