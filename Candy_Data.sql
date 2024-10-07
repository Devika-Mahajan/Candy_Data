Use 
US_Candy_Dist

SELECT * From candy_factories

/* Question: Write a query to list the Product Name, Factory, Unit Price, 
and the Latitude and Longitude of each factory by joining the Candy_Products and Candy_Factories 
tables on the Factory column. */

SELECT 
candy_products.Product_Name,
candy_products.Factory,
candy_products.Unit_Price,
candy_factories.Longitude,
candy_factories.Latitude
From candy_products
Join candy_factories on candy_products.Factory = candy_factories.Factory


/* Write a query to find the total sales and total units sold for each Division in the 
Candy_Sales table where the total sales are greater than 5000. Display the Division, Total_Sales, and Total_Units*/

SELECT 
    Division, SUM(Sales) AS Total_Sales, SUM(Units) Total_Units
FROM
    candy_sales
GROUP BY Division
having Total_Sales > 5000

/* Write a query to categorize Candy_Products based on their Unit Price:
'Premium' for Unit Price > 10
'Standard' for Unit Price between 5 and 10
'Budget' for Unit Price < 5 */

SELECT * From Candy_products

SELECT 
Unit_Price,
Case
	When Unit_Price > 10 Then 'Premium'
	When Unit_Price Between 5 And 10 Then 'Standard'
	When Unit_Price < 5 Then 'Budget'
	End As 'Product_Category'
From candy_products

/* Write a query to display the Product Name and Sales for products in the Candy_Sales 
table where Division is either 'Other, 'Chocolate', and Product Name starts with 'W'.
Use the IN and LIKE operators to filter the results.*/

SELECT 
Product_Name,
Sales,
Division
From candy_sales
Where Division IN ('Other', 'Chocolate') and Product_Name like 'W%'

/* Write a query to find the Customer ID, Product Name, and Sales for orders in the Candy_Sales
 table where the Sales amount is between 100 and 500. */ 
 
 SELECT 
 Customer_ID,
 Product_Name,
 Sales
 From candy_sales
 Where Sales Between 100 and 500
 
 /* Write a query to display all distinct cities (City) from the Candy_Sales table */
 
 Select distinct 
 City
 From candy_sales
 
/* Write a query to find all orders from the Candy_Sales table where:

The Country/Region is 'United States'
Sales are above 300
Ship Mode is 'Second Class' or 'Standard Class' */
 
 Select * from candy_sales
 
 
 Select 
 Country,
 Sales,
 Ship_mode
 From candy_sales
 Where Country = 'United States' or Ship_Mode = ('Second Class' or 'Standard Class')
 Having sales > 20 
 
 /* Write a query to list the Division, Target, Total Sales,
 and Difference (Total Sales - Target) by joining the Candy_Sales and Candy_Targets tables on Division. */
 
 SELECT 
    candy_targets.Division,
    candy_targets.Target,
    SUM(candy_sales.Sales) AS Total_Sales,
    SUM(candy_sales.Sales) - candy_targets.Target
FROM
    candy_sales
        JOIN
    candy_targets ON candy_sales.Division = candy_targets.Division
GROUP BY candy_targets.Division , candy_targets.Target

 
/* Write a query to display Division, Sales, and Gross Profit from the Candy_Sales table, 
sorted in descending order of Gross Profit.
*/


SELECT 
Division,
Sales,
Gross_Profit
From candy_sales
Order by Gross_Profit desc


/*Write a query to find the average unit cost and total units sold for each Division in the Candy_Products table.
 Display Division, Average_Unit_Cost, and Total_Units_Sold.
*/


SELECT 
    candy_products.Division, 
    AVG(candy_products.Unit_Cost) AS Average_Unit_Cost, 
    SUM(candy_sales.Units) AS Total_Units_Sold
FROM candy_products
Join candy_sales on candy_products.Division = candy_sales.Division
GROUP BY candy_sales.Division;


/* Insert a new product into the Candy_Products table with the following details:

Division: 'Chocolate'
Product Name: 'Dark Choco Bites'
Factory: 'Factory1'
Product ID: 501
Unit Price: 8
Unit Cost: 5 */


SELECT * FRom candy_products
INSERT INTO candy_products
Values
('Chocolate', 'Dark Choco Bites', 'Sugar Shack', 501, 8, 5)

/*Write a query to calculate the running total of sales for each division in the 
candy_sales table, ordered by order date.*/

SELECT 
Sales,
Order_Date,
Division,
SUM(sales) over (partition by Division order by Order_Date) as Total_sales_by_division
from candy_sales
ORDER BY 
    Division, Order_Date
    
    
/*Write a query to retrieve the Order ID, Order Date, Product Name, 
Unit Price, and Sales by joining the candy_sales and candy_products tables.*/

SELECT
candy_sales.Order_ID,
candy_sales.Order_Date,
candy_products.Product_Name,
candy_products.Unit_Price,
candy_sales.Sales
From candy_sales
Join candy_products on candy_sales.Division = candy_products.Division



/*Write a query to list the top 5 products by total sales.*/

SELECT
candy_products.Product_Name,
Sum(candy_sales.Sales) as Total_Sales
From candy_sales
Join candy_products on candy_sales.Division = candy_products.Division
Group by Product_name
Limit 5

/*Write a query that categorizes the total sales for each product into 
'Underperforming', 'Average', and 'High Performer'.
*/

SELECT
candy_products.Product_Name,
Sum(candy_sales.Sales) as Total_Sales,
Case 
When Sum(candy_sales.Sales) < 100 Then 'Underperforming'
When Sum(candy_sales.Sales) between 500 and 700 Then 'Average'
Else 'High Performer'
End As 'Catogory'
From candy_sales
Join candy_products on candy_sales.Division = candy_products.Division
Group by candy_products.Product_Name

/* Write a query to calculate the average sales for each division.*/

Select
AVG(Sales) as Average_sales_by_division,
Division
From candy_sales
Group by Division

/*Write a query to list products that have not met their sales targets by joining candy_products and candy_targets*/

SELECT 
candy_products.Product_Name,
SUM(candy_sales.Sales)as total_sales,
From candy_sales
Join candy_targets on candy_sales.Division = candy_targets.Division
left Join candy_products on candy_products.Division = candy_sales.Division 
Group by candy_targets.Division, candy_targets.Target, candy_products.Product_Name
Having Total_Sales < candy_targets.Target


SELECT 
    cp.Product_Name,
    ct.Target,
    SUM(cs.Sales) AS Total_Sales
FROM 
    candy_products cp
JOIN 
    candy_targets ct ON cp.Division = ct.Division
LEFT JOIN 
    candy_sales cs ON cp.Product_ID = cs.Product_ID
GROUP BY 
    cp.Product_Name, ct.Target
HAVING 
    Total_Sales < ct.Target

/*Write a query to rank products based on total sales using a window function*/

SELECT
candy_products.Product_Name, 
Sum(candy_sales.Sales) as Total_Sales,
Rank() over (order by Sum(candy_sales.Sales) desc)  as row1
From candy_sales
Join candy_products on candy_products.Product_ID = candy_sales.Product_ID

Group by candy_products.Product_Name


/* Write a query to calculate both the total sales and average unit price for each division. */

SELECT
candy_sales.Division,
SUM(candy_sales.Sales) as Total_Sales,
AVG(candy_products.Unit_Price) as 'average unit price for each division'

From candy_sales
Join candy_products on candy_products.Product_ID = candy_sales.Product_ID
Group by candy_sales.Division


/* Write a query to categorize orders into 'Recent', 'This Month', and 'Earlier' based on the order date. */

SELECT
Product_Name,
Order_Date,
Case 
When Order_Date > '2024-12-20' Then 'Recent'
When Order_Date between '2024-12-01' and '2024-12-20' Then 'This Month'
When Order_Date < '2024-12-01' Then 'Earlier'
End as 'Order_status'
From candy_sales 
Order by Order_Date desc


/* Write a query to find the total sales for each division and rank them in descending order.*/

Select 
Rank() over (order by Sum(Sales) desc) as Rank_sales,
Sum(Sales) as Total_Sales,
Division
From candy_sales
Group by Division

/* Write a query to calculate the average unit price for each product and categorize them as 
'Expensive', 'Moderate', or 'Cheap' */

Select
Product_Name,
AVG(Unit_Price) as AVG_Unit_Price, 
Case 
When AVG(Unit_Price) > 7 then 'Expensive'
When AVG(Unit_Price) between 3 and 7 then 'Moderate'
When AVG(Unit_Price) < 3 Then 'Cheap'
End as product_price_category
From candy_products
Group by Product_Name

/* Write a query to show the total sales for each month in a year along with the average sales per month.*/

SELECT 
DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
Sum(Sales) as Total_Sales,
AVG(Sales) as Avg_Sales
From candy_sales
group by Month
Order by Month

/* Write a query to compare total sales against targets for each division, 
showing the division, total sales, target, and the difference. */

SELECT
candy_sales.Division,
Sum(candy_sales.Sales) as Total_Sales,
candy_targets.Target,
candy_targets.Target - Sum(candy_sales.Sales) as difference 
From candy_sales
join candy_targets on candy_sales.Division = candy_targets.Division
Group by candy_sales.Division, candy_targets.Target

/* Write a query to find the factory with the most products, showing the factory name and the number of products. */

select
Factory,
Count(Product_Name) as Total_no_of_Products
from candy_products
group by Factory
Order by Total_no_of_Products desc

/* Write a query to retrieve the top 5 products with the highest gross profit. */

SELECT 
Product_Name,
Sum(Gross_Profit) as Total_Gross_Profit
From candy_sales
Group by Product_Name
order by Total_Gross_Profit desc

Limit 5

/* Write a query to find products sold, their unit prices, and the total sales revenue generated from them. */

SELECT 
candy_products.Product_Name,
candy_products.Unit_Price,
SUM(candy_sales.Sales) as Total_Sales
FROM candy_sales
JOIN candy_products on candy_sales.Product_Name = candy_products.Product_Name 
Group by candy_products.Product_Name, candy_products.Unit_Price


/*Write a query to calculate the average sales for each region and display the region along with average sales.*/

SELECT
Region,
AVG(Sales)
From candy_sales
group by Region

/*Write a query to show the total sales distributed by shipping mode, including a percentage of total sales*/

SELECT 
Ship_Mode,
SUM(Sales) as Total_Sales,
(SUM(Sales) / (SELECT SUM(Sales) FROM candy_sales) * 100) AS Sales_Percentage
From candy_sales
group by ship_Mode

/*Write a query to calculate the year-over-year sales growth for each year.*/

SELECT 
Year(Order_Date) as Year,
SUM(Sales) As Total_Sales,
LAG(SUM(Sales), 1) OVER (ORDER BY YEAR(Order_Date)) AS Previous_Year_Sales, 
(SUM(Sales) - Previous_Year_Sales) / Previous_Year_Sales * 100 AS Growth_Percentage
FROM
    candy_sales
GROUP BY
    YEAR(Order_Date)
