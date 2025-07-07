SELECT COUNT (transactions-id) AS number_of_sales
FROM analysis.sales.brightdata;

SELECT SUM(transaction_qty) AS number_of_units_sold
FROM analysis.sales.brightdata;

SELECT transaction_qty*unit_price AS revenue_per_transaction
FROM analysis.sales.brightdata;

-- Calculating the total revenue
SELECT SUM(transaction_qty*unit_price) AS total_revenue
FROM analysis.sales.brightdata;

-- Revenue product category
SELECT SUM(transaction_qty*unit_price) AS total_revenue,
product_category
FROM analysis.sales.brightdata
GROUP BY product_category
ORDER BY total_revenue DESC;

--Get the earliest time in which the shop opens
SELECT MIN(transaction_time)
FROM analysis.sales.brightdata;

--Get the latest time in which the shop closes
SELECT MAX(transaction_time)
FROM analysis.sales.brightdata;

SELECT
SUM(transaction_qty*unit_price)AS total_revenue,
SUM(transaction_qty) AS number_of_units_sold,
COUNT(transaction_id) AS number_of_sales,

 TO_CHAR(transaction_date,'YYYYMM') AS month_id,
 MONTHNAME(transaction_date)AS month_name,
CASE
WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
WHEN transaction_time BETWEEN '16:00:00' AND '20:00:00' THEN 'EVENING'
ELSE 'Goodnight'
END AS time_bucket,

   product_category,
   product_type,
   product_detail,
   store_location
FROM analysis.sales.brightdata
GROUP BY time_bucket,
product_category,
product_type,
product_detail,
store_location,
transaction_date

