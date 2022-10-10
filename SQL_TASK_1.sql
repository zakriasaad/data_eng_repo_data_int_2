
--DROP TABLE IF EXISTS order_aggs;
CREATE TEMP TABLE order_aggs AS 
SELECT sum(od.UnitPrice),o.ShipCountry,
	(CASE WHEN sum(od.UnitPrice) > 5000 THEN 'high_sales'
		WHEN  sum(od.UnitPrice) < 1500  THEN 'low_sales'
		ELSE 'Medium sales' END) AS PriceCategory
from 'Order Details' od
join Orders o
on od.OrderID=o.OrderID 
group by o.ShipCountry

select *
from order_aggs

select * 
from orders
--Checking the highest sales in 2016 by ShipCountry
select o.OrderDate,o.ShipCountry,ord.PriceCategory
from Orders o 
join order_aggs ord
on o.ShipCountry=ord.ShipCountry
where o.OrderDate like '2016%'