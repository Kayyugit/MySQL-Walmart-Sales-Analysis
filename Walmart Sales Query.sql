  
-- -----------FEATURE ENGINEERING---------

SELECT 
	time,
    (CASE
		WHEN time between "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time between "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE 'Evening'
	END
    ) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN time between "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN time between "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE 'Evening'
	END
);


-- day_name
SELECT
	date,
    DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

-- Now we populate the columns with the information to match the details with the info

UPDATE sales
SET day_name = DAYNAME(date);

-- month_name

SELECT
	date,
    MONTHNAME(date)
FROM sales;

-- alter the table to add a column that for month name 
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

-- POPULATE TABLE WITH THE MONTH NAME

UPDATE sales
SET month_name = MONTHNAME(date);

-- -----------------------------------------------------------------------
-- ---------------Generic questions-------

-- How many unique cities does the data have?
SELECT
	DISTINCT city
FROM sales;

-- How many branches?

SELECT
	DISTINCT branch
FROM sales;

-- in which city is each branch?
SELECT
	DISTINCT city,
    branch
FROM sales;

-- -----------------Product-----------

-- How many unique product lines does the data have?
SELECT
	COUNT(DISTINCT product_line)
FROM sales;

-- What is the most common payment method?
SELECT
	payment_method,
    COUNT(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;

-- What is the most selling product line?
SELECT
	product_line,
    COUNT(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total revenue by month?
SELECT
	month_name AS month,
    SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest cost of goods sold (COGS)?
SELECT
	month_name AS month,
    SUM(cogs) AS cogs
FROM sales
GROUP BY month_name
ORDER BY cogs DESC;

-- What product line had the largest revenue?
SELECT
	product_line,
    SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	branch,
    city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?
SELECT
	product_line,
    AVG(VAT) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;
-- you'll notice that this is averaged. Just like inthe case of the Power BI tutorial
-- when dealing with percentages, get the average of the percentage not the total

-- Which branch sold more products than average product sold?
SELECT
	branch,
    SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM Sales);

-- What is the most common product line by gender?
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line?
SELECT
	ROUND(AVG(rating), 2) AS avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- -------------- Sales--------

-- Number of sales made in each time of the day per weekday
SELECT
	time_of_day,
    COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Monday"
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
    SUM(total) AS total_rev
FROM sales
GROUP BY customer_type
ORDER BY total_rev DESC;

-- Which city has the largest tax/ VAT (Value Added Tax)?
SELECT
	city,
    AVG(VAT) AS VAT
FROM sales
GROUP BY city
ORDER BY VAT DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
    AVG(VAT) AS VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT DESC;

-- -----------------------------------------------
-- -------------- Customer ----------------
-- How many unique customer types does the data have?
SELECT
	COUNT(DISTINCT customer_type)
FROM sales;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment_method
FROM sales;

-- What is the most common customer type?
SELECT
	customer_type,
	COUNT(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*) AS cstm_cnt
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;
-- Gender per branch is more or less the same hence, I don't think has
-- an effect of the sales per branch and other factors.
-- Change the branch = "C" to "A" or "B" to get info about that branch

-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter

-- Which time of the day do customers give most ratings per branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.

-- Which day for the week has the best avg ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the case, how many sales are made on these days?

-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;
-- Evenings experience most sales, the stores are 
-- filled during the evening hours

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;