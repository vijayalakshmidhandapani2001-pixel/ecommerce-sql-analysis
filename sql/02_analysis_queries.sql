USE EcommerceAnalysis;
GO

-- ============================================================
-- Q1. Orders and Revenue by Customer State
-- Question: How many orders did each customer state make,
-- and what's the total revenue generated from each state?
-- Skill: Multi-table JOIN, GROUP BY, COUNT DISTINCT, SUM
-- ============================================================
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;
GO


-- ============================================================
-- Q2. Monthly Revenue Trend
-- Question: What is the total revenue and number of orders
-- for each month, across the entire dataset?
-- Skill: JOIN, GROUP BY, date formatting
-- ============================================================
SELECT
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS order_month,
    SUM(oi.price) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY order_month;
GO


-- ============================================================
-- Q3. Monthly Revenue with Previous Month Shown
-- Question: What was each month's revenue, alongside the
-- previous month's revenue for comparison?
-- Skill: CTE (temporary named query), LAG window function
-- ============================================================
WITH monthly_revenue AS (
    SELECT
        FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS order_month,
        SUM(oi.price) AS revenue
    FROM olist_orders_dataset o
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
)
SELECT
    order_month,
    revenue,
    LAG(revenue) OVER (ORDER BY order_month) AS prev_month_revenue
FROM monthly_revenue;
GO


-- ============================================================
-- Q4. Top 10 Product Categories by Revenue
-- Question: Which product categories generate the most
-- revenue, and how many orders does each have?
-- Skill: JOIN, GROUP BY, TOP, ORDER BY
-- ============================================================
SELECT TOP 10
    p.product_category_name,
    SUM(oi.price) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;
GO


-- ============================================================
-- Q5. Multi-Item Order Rate
-- Question: How many orders contain more than one item, and
-- what percentage of all orders does that represent?
-- Skill: Subquery, HAVING, percentage calculation
-- ============================================================
SELECT
    (SELECT COUNT(*) FROM (
        SELECT order_id FROM olist_order_items_dataset
        GROUP BY order_id HAVING COUNT(*) > 1
    ) AS multi) AS multi_item_orders,
    (SELECT COUNT(DISTINCT order_id) FROM olist_order_items_dataset) AS total_orders,
    ROUND(
        (SELECT COUNT(*) FROM (
            SELECT order_id FROM olist_order_items_dataset
            GROUP BY order_id HAVING COUNT(*) > 1
        ) AS multi) * 100.0
        / (SELECT COUNT(DISTINCT order_id) FROM olist_order_items_dataset)
    , 2) AS pct_multi_item_orders;
GO


-- ============================================================
-- Q6. Average Delivery Time by Customer State
-- Question: What is the average number of days it takes for
-- an order to be delivered, broken down by customer state?
-- Skill: JOIN, DATEDIFF, GROUP BY
-- ============================================================
SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders,
    AVG(DATEDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date)) AS avg_delivery_days
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;
GO


-- ============================================================
-- Q7. Customer Spending Rank
-- Question: For each customer, what was their total spend,
-- and how do they rank against all other customers?
-- Skill: CTE, RANK window function
-- ============================================================
WITH customer_totals AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS total_spent
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
)
SELECT
    customer_unique_id,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
FROM customer_totals;
GO
