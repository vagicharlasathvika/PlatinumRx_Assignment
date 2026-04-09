-- Q1: For every user, get user_id and last booked room_no
SELECT 
    b.user_id,
    b.room_no
FROM bookings b
INNER JOIN (
    SELECT user_id, MAX(booking_date) AS last_booking_date
    FROM bookings
    GROUP BY user_id
) latest ON b.user_id = latest.user_id 
        AND b.booking_date = latest.last_booking_date;


-- Q2: Get booking_id and total billing amount for November 2021
SELECT 
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date >= '2021-11-01' 
  AND bc.bill_date <  '2021-12-01'
GROUP BY bc.booking_id;


-- Q3: Get bill_id and bill amount for October 2021 where amount > 1000
SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE bc.bill_date >= '2021-10-01' 
  AND bc.bill_date <  '2021-11-01'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;



-- Q4: Most and least ordered item of each month in 2021
WITH monthly_totals AS (
    SELECT
        MONTH(bc.bill_date)      AS month_number,
        MONTHNAME(bc.bill_date)  AS month_name,
        i.item_name,
        SUM(bc.item_quantity)    AS total_quantity
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), MONTHNAME(bc.bill_date), i.item_name
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY month_number ORDER BY total_quantity DESC) AS rank_high,
        RANK() OVER (PARTITION BY month_number ORDER BY total_quantity ASC)  AS rank_low
    FROM monthly_totals
)
SELECT 
    month_name,
    item_name,
    total_quantity,
    CASE 
        WHEN rank_high = 1 THEN 'Most Ordered'
        WHEN rank_low  = 1 THEN 'Least Ordered'
    END AS order_type
FROM ranked
WHERE rank_high = 1 OR rank_low = 1
ORDER BY month_number;



-- Q5: Customer with 2nd highest bill value of each month in 2021
WITH bill_totals AS (
    SELECT
        MONTH(bc.bill_date)     AS month_number,
        MONTHNAME(bc.bill_date) AS month_name,
        b.user_id,
        u.name,
        bc.bill_id,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN items    i ON bc.item_id    = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users    u ON b.user_id     = u.user_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY 
        MONTH(bc.bill_date), 
        MONTHNAME(bc.bill_date), 
        b.user_id, 
        u.name, 
        bc.bill_id
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (
            PARTITION BY month_number 
            ORDER BY bill_amount DESC
        ) AS bill_rank
    FROM bill_totals
)
SELECT
    month_name,
    user_id,
    name,
    bill_id,
    bill_amount
FROM ranked
WHERE bill_rank = 2
ORDER BY month_number;