/* 
  Project: AdventureWorksDW — SQL Practice (17 queries)
  Author: Zohair Raza
  Date: 26/08/2025
  Notes: Tested on Microsoft SQL Server (AdventureWorksDW)
*/





-- Q1:Simple selecting every coulumn from Customers Table 
SELECT *

FROM DimCustomer




-- Q2:Querying to get some columns from Customers Table (Includes some basic funtions)
SELECT
    CONCAT(FirstName, ' ', LastName) AS CustomerName,
    BirthDate,
    DATEDIFF(yy, BirthDate, GETDATE()) AS Age,
    Gender,
    EmailAddress,
    YearlyIncome

FROM DimCustomer




-- Q3:Filtering data from previous output and then sorting
SELECT
    CONCAT(FirstName, ' ', LastName) AS CustomerName,
    BirthDate,
    DATEDIFF(yy, BirthDate, GETDATE()) AS Age,
    Gender,
    EmailAddress,
    YearlyIncome

FROM DimCustomer

WHERE DATEDIFF(yy, BirthDate, GETDATE()) > 70 AND Gender = 'M'

ORDER BY Age DESC




-- Q4:Filterig data using AND Operator
SELECT 
    SalesOrderNumber,
    TotalProductCost,
    SalesAmount

FROM FactInternetSales

WHERE SalesAmount > 3000 AND TotalProductCost > 2000




-- Q5:Counting the number of Customers & their average income
SELECT 
	COUNT(*) AS NumberOfCustomers,
	ROUND (AVG(YearlyIncome), 1) AS AvgCustIncome

FROM DimCustomer




-- Q6:Using Aggregate funtions & grouping data by SalesOrderNumber
SELECT 
    SalesOrderNumber,
    AVG (TotalProductCost) AS AvgProdCost,
    AVG(SalesAmount) AS AvgSalesAmt

FROM FactInternetSales

GROUP BY SalesOrderNumber

HAVING AVG(SalesAmount) > 3500




-- Q7:Grouping data by OrderDate & SalesOrderNumber & then sorting  --
SELECT
    OrderDate,
    SalesOrderNumber,
    ROUND (SUM(TotalProductCost), 1) AS AggProdCost,
    SUM(SalesAmount) AS TotalSalesAmt,
    ROUND (SUM(TaxAmt), 1) AS TotalTaxAmt

FROM FactInternetSales

GROUP BY OrderDate, SalesOrderNumber

ORDER BY OrderDate DESC




-- Q8:Calculating Total number of Customers
SELECT 
    CustomerKey,
    COUNT(CustomerKey) AS OrderPerCustomer

FROM FactInternetSales

GROUP BY CustomerKey




-- Q9:Total SalesAmount grouped by CustomerKey & sorted out
SELECT 
    CustomerKey,
    SUM(SalesAmount) AS SumOfSales

FROM FactInternetSales

GROUP BY CustomerKey

HAVING SUM(SalesAmount) > 10000




-- Q10:Month of order & Total SalesAmount, grouped and sorted by the month
SELECT TOP (100) 
    DATEPART(MONTH, OrderDate) AS OrderMonth,
    ROUND(SUM(SalesAmount), 1) AS SumOfSales
FROM FactInternetSales

GROUP BY DATEPART(MONTH, OrderDate)

ORDER BY OrderMonth 




-- Q11:Average number of calls and orders in each shift
SELECT 
    Shift,
    AVG (Calls) AvgCalls,
    AVG (Orders) AvgOrders

FROM FactCallCenter

GROUP BY Shift




-- Q12:Average SafetyStockLevel & ReorderPoint of each Product, sorted by average SafetyStockLevel
SELECT 
    EnglishProductName,
    AVG(SafetyStockLevel) AS AvgSafetyStock,
    AVG(ReorderPoint) AS AvgReorderPoint

FROM DimProduct

GROUP BY EnglishProductName

ORDER BY AvgSafetyStock DESC




-- Q13:Finding the iformation about all the customers irrespective if they made a purchase or not
SELECT 
	f.OrderDate,
	f.SalesOrderNumber,
	f.SalesOrderLineNumber AS InvoiceNumber,
	f.OrderQuantity,
	f.UnitPrice,
	f.SalesAmount,
	f.TaxAmt,
	d.FirstName,
	d.LastName,
	d.BirthDate,
	d.MaritalStatus,
	d.Gender,
	d.YearlyIncome

FROM DimCustomer AS d
	LEFT JOIN FactInternetSales AS f
	ON f.CustomerKey=d.CustomerKey
	
	


-- Q14:Relevent information about the products that made sales
SELECT  
	p.ProductKey,
    p.EnglishProductName,
    f.SalesOrderNumber,
    f.SalesAmount

FROM FactInternetSales f
	RIGHT JOIN DimProduct p
    ON f.ProductKey = p.ProductKey
	
	
	
	
-- Q15:Relevent information about the customers and their purchase details
SELECT 
	f.OrderDate,
	f.SalesOrderNumber,
	f.OrderQuantity,
	f.UnitPrice,
	f.SalesAmount,
	f.TaxAmt,
	CONCAT(d.FirstName, ' ', d.LastName) AS CustomerName,
	DATEDIFF( YY, d.BirthDate, GETDATE()) AS Age,
	d.Gender,
	d.YearlyIncome

FROM FactInternetSales AS f
	INNER JOIN DimCustomer AS d
	ON f.CustomerKey=d.CustomerKey
	
	
	

-- Q16:Combining 4 tables using multiple inner joins to find all the relavent information regarding sales, products, categories & sub categories	
SELECT  
	F.SalesOrderNumber,
	F.OrderQuantity,
	F.UnitPrice,
	F.SalesAmount,
	f.TaxAmt,
	f.OrderDate,
	p.EnglishProductName,
	p.StandardCost,
	p.SafetyStockLevel,
	p.ReorderPoint,
	p.ListPrice,
	p.[Size],
	p.DealerPrice,
	ps.EnglishProductSubcategoryName,
	pc.EnglishProductCategoryName


FROM FactInternetSales AS f
	INNER JOIN DimProduct AS p
	ON f.ProductKey=p.ProductKey
	INNER JOIN DimProductSubcategory AS ps
	ON p.ProductSubcategoryKey=ps.ProductSubCategoryKey
	INNER JOIN DimProductCategory AS pc
	ON ps.ProductCategoryKey=pc.ProductCategoryKey
	
	


-- Q17:Combining aggregate funtions and joins to find monthly sales report with total revenue and customer count per month.
SELECT 
	d.CalendarYear, 
	d.MonthNumberOfYear, 
	d.EnglishMonthName,
	COUNT(DISTINCT f.CustomerKey) AS CustomerCount,
	SUM(f.SalesAmount) AS TotalSales

FROM FactInternetSales f
	INNER JOIN DimDate d
    ON f.OrderDateKey = d.DateKey

GROUP BY 
	d.CalendarYear, 
	d.MonthNumberOfYear, 
	d.EnglishMonthName

ORDER BY 	
	d.CalendarYear,
	d.MonthNumberOfYear














