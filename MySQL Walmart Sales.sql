-- WALMART SALES ANALYSIS
-- Download data from kaggle and then import, link will be provided in README

-- ----------1. Sales Performance by Branch and City----------
-- 01 - Total sales per branch
SELECT Branch, SUM(Total) AS Sales_per_Brach
FROM sales
GROUP BY Branch;
-- Based on the data, branch C had the highest sales, A has the second highest then B

-- 02 - Total sales per city:
SELECT City, SUM(Total) AS Sales_by_City
FROM sales
GROUP BY City;
-- Based on the data, Naypyitaw comes first, Yangon second, then Mandalay

-- 03 - Comparison of sales between branches
SELECT Branch, City, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Branch, City;

-- ----------2. Customer Analysis----------
-- 04 - Sales breakdown by customer type:
SELECT Customer_Type, SUM(Total) AS Total_Member_Sales
FROM sales
GROUP BY Customer_Type;
-- It shows that members make up more of the sales by about 6000

-- 05 - Gender-wise sales distribution
SELECT Gender, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Gender
ORDER BY Gender;
-- Females make more of the total sales by about $12000

-- 06 - Average rating given by customers segmented by branch
SELECT Branch, AVG(Rating) AS Average_Rating
FROM sales
GROUP BY Branch;
-- The rating between the highest rating and the second, C and A, is not really significant 
-- However, branch B has a noticable difference

-- ----------3. Product Line Analysis----------
-- 07 - Total sales per product line:
SELECT Product_Line, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Product_Line;
-- Food and beverages has the highest sales 

-- 08 - Average unit price per product line:
SELECT Product_Line, AVG(Unit_Price) AS Average_Unit_Price
FROM sales
GROUP BY Product_Line;
-- Fashion and accessories has the highest average unit price while Electronic accessories has the lowest

-- 09 - Quantity sold per product line:
SELECT Product_Line, SUM(Quantity) AS Total_Quantity_Sold
FROM sales
GROUP BY Product_Line
ORDER BY Total_Quantity_Sold DESC;
-- Electronic accessories has the highest quantity while Health and beauty has the lowest

-- ----------4. Time-Based Analysis----------
-- 10 - Monthly sales trends:
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Month
ORDER BY Total_Sales DESC;
-- January had the highest sales, March comes in second and Feb comes in third

-- 11 - Daily sales trends:
SELECT Date, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Date
ORDER BY Total_Sales DESC;

-- 12 - Peak sales hours
SELECT HOUR(Time) AS Hour, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Hour
ORDER BY Total_Sales DESC;
-- 7pm has the highest volume of sales, 8pm has the lowest

-- ---------5. Payment Method Analysis----------
-- 13 - Distribution of sales by payment method:
SELECT Payment_method, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Payment_method
ORDER BY Total_Sales DESC;
-- Cash has the highest sales, Ewallet second and Credit card third

-- 14 - Average transaction amount by payment method:
SELECT Payment_method, AVG(Total) AS Average_Transaction_Amount
FROM sales
GROUP BY payment_method;

-- ---6. Gross Income and Margin Analysis----
-- 15 - Average gross income per transaction:
SELECT AVG(Gross_Income) AS Average_Gross_Income
FROM sales;

-- 16 - Gross income and margin by branch:
SELECT Branch, SUM(Gross_Income) AS Total_Gross_Income, 
AVG(Gross_Margin_PCT) AS Average_Gross_Margin_Percentage
FROM Sales
GROUP BY Branch
ORDER BY Total_Gross_Income DESC;
-- No difference in Average Gross Margin Percentage for all branches

-- 17 - Gross income and margin by product line:
SELECT Product_Line, SUM(Gross_Income) AS Total_Gross_Income, 
AVG(Gross_Margin_Pct) AS Average_Gross_Margin_Percentage
FROM sales
GROUP BY Product_Line
ORDER BY Total_Gross_Income DESC;

-- ----------7. Customer Ratings Analysis----------
-- 18 - Average customer rating by city:
SELECT City, AVG(Rating) AS Average_Rating
FROM sales
GROUP BY City
ORDER BY Average_Rating DESC;

-- 19 - Correlation between customer rating and sales amount (basic correlation):
SELECT Rating, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Rating
ORDER BY Rating DESC;

SELECT Rating, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Rating
ORDER BY Total_Sales DESC;
-- Interestingly enough, the third lowest rating has the highest sales

-- ----------8. Analyze Current Sales Performance----------
-- 20 - Total sales and quantity sold per product line:
SELECT Product_Line, SUM(Total) AS Total_Sales, SUM(Quantity) AS Total_Quantity_Sold
FROM sales
GROUP BY Product_Line
ORDER BY Total_Sales DESC;

-- ----------9. Identify High-Performing and Underperforming Product Lines----------
-- 21 - Identify top 5 high-performing product lines
SELECT Product_Line, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Product_Line
ORDER BY Total_Sales DESC
LIMIT 5;  

-- - Identify top 5 under-performing product lines
SELECT Product_Line, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Product_Line
ORDER BY Total_Sales ASC
LIMIT 5;

-- ----------10. Customer Preferences and Demographics-----------
-- 22 - Customer demographics for each product line:
SELECT Product_Line, Gender, Customer_Type, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Product_Line, Gender, Customer_Type;

-- ----------11. Sales Trends Over Time----------
-- 23. Monthly sales trends for each product line:
SELECT Product_Line, DATE_FORMAT(Date, '%Y-%m') AS Month, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Product_Line, Month
ORDER BY Total_Sales DESC;

-- ----------12. Evaluate Pricing Strategy----------
-- 24. Average unit price and total sales per product line:
SELECT Product_Line, AVG(Unit_Price) AS Average_Unit_Price, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Product_Line
ORDER BY Average_Unit_Price DESC;

SELECT Product_Line, AVG(Unit_Price) AS Average_Unit_Price, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Product_Line
ORDER BY Total_Sales DESC;

-- -----------13. Customer Feedback and Ratings----------
-- 25 Average customer rating per product line:
SELECT Product_Line, AVG(Rating) AS Average_Rating
FROM sales
GROUP BY Product_Line
ORDER BY Average_Rating DESC;

-- ----------14. Optimize Inventory Management-----------
-- 26. Quantity sold per product line over time to identify demand patterns:
SELECT Product_Line, DATE_FORMAT(Date, '%Y-%m') AS Month, SUM(Quantity) AS Total_Quantity_Sold
FROM sales
GROUP BY Product_Line, Month
ORDER BY Month;

-- -----------15. Marketing and Promotions-----------
-- 27. Evaluate the impact of promotions on sales for each product line:
SELECT Product_Line, payment_method, SUM(Total) AS Total_Sales
FROM sales
WHERE Payment_method IN ('Ewallet', 'Credit card', 'Cash')  -- Assuming these are promotional payment methods
GROUP BY Product_Line, Payment_method
ORDER BY Total_Sales DESC;

-- ----------16. Average Transaction Value----------
-- 28. Understanding the average transaction value can help in setting targets and evaluating performance.
SELECT AVG(Total) AS Average_Transaction_Value
FROM sales;

-- ----------17. Customer Visit Patterns---------
-- 29. Identifying patterns in customer visits can help optimize staffing and store operations.
-- We can do this by looking at the most common visit days:
SELECT DAYNAME(Date) AS Day, COUNT(*) AS Visit_Count
FROM sales
GROUP BY Day
ORDER BY Visit_Count DESC;

-- Also, looking at the most common visit times:
SELECT HOUR(Time) AS Hour, COUNT(*) AS Visit_Count
FROM sales
GROUP BY Hour
ORDER BY Visit_Count DESC;

-- ----------18. Customer Loyalty----------
-- 30. Analyze the behavior of different customer types (Member vs Normal).
-- Repeat purchase rate for Members vs Normal customers:
SELECT Customer_Type, COUNT(DISTINCT Invoice_ID) AS Number_of_Purchases, COUNT(DISTINCT Customer_Type) AS Number_of_Customers, 
       COUNT(DISTINCT Invoice_ID) / COUNT(DISTINCT Customer_Type) AS Repeat_Purchase_Rate
FROM sales
GROUP BY Customer_Type;

-- ----------19. Seasonal Trends----------
-- 31. Identifying seasonal trends can help in planning inventory and marketing campaigns.
-- Quarterly sales trends:
SELECT QUARTER(Date) AS Quarter, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Quarter
ORDER BY Quarter;
-- There isn't  enough data the show alot of details, I'll leave it here just incase I want to use it

-- -----------20. Product Line Popularity by City----------
-- 32. Understanding product line popularity in different cities can guide localized marketing efforts.
SELECT City, Product_Line, SUM(Total) AS Total_Sales
FROM sales
GROUP BY City, Product_Line
ORDER BY City, Total_Sales DESC;

-- ---------21. Gender-wise Product Preferences----------
-- 33. Analyzing gender-wise preferences can help in targeted marketing.
SELECT Gender, Product_Line, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Gender, Product_Line
ORDER BY Total_Sales DESC;

-- ----------22. High-Value Customers--------
-- 34. Identifying high-value customers can help in loyalty programs and personalized marketing.
SELECT Invoice_ID, Customer_Type, Gender, SUM(Total) AS Total_Spent
FROM sales
GROUP BY Invoice_ID, Customer_Type, Gender
HAVING Total_Spent > (SELECT AVG(Total) FROM sales)
ORDER BY Total_Spent DESC;

-- ----------23. Correlation Analysis----------
-- 35. Understanding the correlation between different variables can provide deeper insights into customer behavior and sales patterns.
-- Correlation between quantity and total sales:
SELECT Product_Line, SUM(Quantity) AS Total_Quantity_Sold, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Product_Line
ORDER BY Total_sales DESC;

SELECT Product_Line, SUM(Quantity) AS Total_Quantity_Sold, SUM(Total) AS Total_Sales
FROM sales
GROUP BY Product_Line
ORDER BY Total_Quantity_Sold DESC;

-- 36. Correlation between gross income and customer ratings:
SELECT Rating, AVG(Gross_Income) AS Average_Gross_Income
FROM sales
GROUP BY Rating
ORDER BY Average_Gross_Income DESC;

SELECT Rating, AVG(Gross_Income) AS Average_Gross_Income
FROM sales
GROUP BY Rating
ORDER BY Rating DESC;

-- -----37. Effectiveness of Marketing Campaigns
-- If there is data on marketing campaigns, analyze their impact on sales.
-- Sales before and after a specific date (assuming a campaign start date):
SELECT 'Before Campaign' AS Period, SUM(Total) AS Total_Sales
FROM sales
WHERE Date < '2019-03-01'
UNION ALL
SELECT 'After Campaign' AS Period, SUM(Total) AS Total_Sales
FROM sales
WHERE Date >= '2019-03-01';
-- This is not really useful now, but I'll leave it here just incase I need it in the future
