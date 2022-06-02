use Northwind
select * from Categories

select * from Orders order by OrderID,EmployeeID
SP_HELP Orders
sp_help OrderDetails

select OrderID,EmployeeID,OrderDate,
Case When DateDiff(d,LAG([OrderDate]) OVER(Partition by EmployeeID order by [OrderDate]),[OrderDate]) <= DATEADD(YEAR,-27,GETDATE()) THEN 1
ELSE 0 END AS Marker
from Northwind..Orders

sp_help Orders

select 
OrderID,
CustomerID,
COUNT(EmployeeID) AS EmployeeID,
OrderDate from Orders GROUP BY OrderID,
CustomerID,
EmployeeID,
OrderDate

--Case When COUNT(EmployeeID) > 0 AND [OrderDate] >= DATEADD(YEAR,-25,GETDATE()) THEN 1 ELSE 0 END AS Marker

-- ord.OrderID = x.OrderID AND 
select  ord.OrderID,ord.EmployeeID,ord.OrderDate,
Case When x.EmployeeCount > 0  THEN 1 ELSE 0 END AS Marker
from  Orders as ord  join 
(SELECT OrderID,EmployeeID,OrderDate,COUNT(EmployeeID) AS EmployeeCount from Orders  where OrderDate >= (DATEADD(MONTH,-310,GETDATE())) group by OrderID,EmployeeID,OrderDate) x 
on (ord.EmployeeID=x.EmployeeID) where ord.OrderDate >= (DATEADD(MONTH,-310,GETDATE())) group by x.OrderID,x.EmployeeID,x.OrderDate


SELECT ord.OrderID,ord.EmployeeID,ord.OrderDate,
Case When ord.EmployeeID=p2.EmployeeID THEN 'E' ELSE 'N' END AS Category_Marker
from Orders as ord left join(
				select OrderID,EmployeeID,OrderDate
				from Northwind.dbo.Orders
				where OrderDate >= (DATEADD(year,-25,GETDATE()))
				group by OrderID,EmployeeID,OrderDate) p2 
				on (p2.OrderID=ord.OrderID)
				where ord.OrderDate >= (DATEADD(year,-26,GETDATE())) 
				group by ord.OrderID,ord.EmployeeID,ord.OrderDate,p2.EmployeeID

			

 
