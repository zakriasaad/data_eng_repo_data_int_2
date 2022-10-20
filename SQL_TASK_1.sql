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


--CATEGORIZING COUNTRIES INTO HIGH.LOW AND MEDIUM SALES
select * 
from orders
select o.OrderDate,o.ShipCountry,ord.PriceCategory
from Orders o 
join order_aggs ord
on o.ShipCountry=ord.ShipCountry
where o.OrderDate like '2016%'





--TOP 10 CUSTOMERS BY MOST NUMBER OF ORDER AND THEIR SHIP COUNTRY
select o.CustomerID,count(*), SUM(od.UnitPrice),o.ShipCountry 
from Orders o 
join "Order Details" od 
on  o.OrderID=od.OrderID 
group by CustomerID 
order by count(*) DESC
limit 10

-- Top Selling Products
--DROP TABLE IF EXISTS Top_Products;
CREATE TEMP TABLE Top_Products AS 
select od.ProductID,p.ProductName,count(ProductName) as Number_of_Orders
from "Order Details" od 
join Products p 
on od.ProductID = p.ProductID 
group by p.ProductName 
order by count(ProductName) DESC

DROP TABLE IF EXISTS Categories_Products;
CREATE TEMP TABLE Categories_Products AS
select p.ProductName,c.CategoryName,c.CategoryID 
from Products p  
join categories c
on p.CategoryID=c.CategoryID 


--Top Categories
select cp.CategoryName,tp.ProductName,tp.Number_of_Orders
from Top_Products tp
join Categories_Products cp 
on tp.ProductName=cp.ProductName