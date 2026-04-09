-- Q1: Revenue per sales channel for a given year
SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel
ORDER BY total_revenue DESC;


-- Q2: Top 10 most valuable customers for a given year
SELECT
    c.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY c.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;


-- Q3: Month-wise revenue, expense, profit, and status
WITH monthly_revenue AS (
    SELECT
        MONTH(datetime) AS month_num,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
monthly_expense AS (
    SELECT
        MONTH(datetime) AS month_num,
        SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT
    r.month_num,
    r.revenue,
    COALESCE(e.expense, 0) AS expense,
    (r.revenue - COALESCE(e.expense, 0)) AS profit,
    CASE
        WHEN (r.revenue - COALESCE(e.expense, 0)) > 0 THEN 'Profitable'
        ELSE 'Not-Profitable'
    END AS status
FROM monthly_revenue r
LEFT JOIN monthly_expense e ON r.month_num = e.month_num
ORDER BY r.month_num;


-- Q4: Most profitable clinic per city for a given month
WITH clinic_profit AS (
    SELECT
        cl.city,
        cs.cid,
        cl.clinic_name,
        MONTH(cs.datetime) AS month_num,
        SUM(cs.amount) - COALESCE(SUM(ex.amount), 0) AS profit,
        RANK() OVER (
            PARTITION BY cl.city, MONTH(cs.datetime)
            ORDER BY (SUM(cs.amount) - COALESCE(SUM(ex.amount), 0)) DESC
        ) AS rnk
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    LEFT JOIN expenses ex ON cs.cid = ex.cid
                          AND MONTH(ex.datetime) = MONTH(cs.datetime)
                          AND YEAR(ex.datetime)  = YEAR(cs.datetime)
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY cl.city, cs.cid, cl.clinic_name, MONTH(cs.datetime)
)
SELECT city, clinic_name, month_num, profit
FROM clinic_profit
WHERE rnk = 1
ORDER BY city, month_num;


-- Q5: Second least profitable clinic per state for a given month
WITH clinic_profit AS (
    SELECT
        cl.state,
        cs.cid,
        cl.clinic_name,
        MONTH(cs.datetime) AS month_num,
        SUM(cs.amount) - COALESCE(SUM(ex.amount), 0) AS profit,
        DENSE_RANK() OVER (
            PARTITION BY cl.state, MONTH(cs.datetime)
            ORDER BY (SUM(cs.amount) - COALESCE(SUM(ex.amount), 0)) ASC
        ) AS rnk
    FROM clinic_sales cs
    JOIN clinics cl ON cs.cid = cl.cid
    LEFT JOIN expenses ex ON cs.cid = ex.cid
                          AND MONTH(ex.datetime) = MONTH(cs.datetime)
                          AND YEAR(ex.datetime)  = YEAR(cs.datetime)
    WHERE YEAR(cs.datetime) = 2021
    GROUP BY cl.state, cs.cid, cl.clinic_name, MONTH(cs.datetime)
)
SELECT state, clinic_name, month_num, profit
FROM clinic_profit
WHERE rnk = 2
ORDER BY state, month_num;