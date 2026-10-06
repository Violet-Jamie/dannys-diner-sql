CREATE DATABASE dannys_diner;
USE dannys_diner;
CREATE TABLE sales (
    customer_id VARCHAR(1),
    order_date DATE,
    product_id INT
);
CREATE TABLE menu (
    product_id INT,
    product_name VARCHAR(50),
    price INT
);
CREATE TABLE members (
    customer_id VARCHAR(1),
    join_date DATE
);
INSERT INTO menu (product_id, product_name, price)
VALUES
(1, 'sushi', 10),
(2, 'Curry', 15),
(3, 'ramen', 12);
INSERT INTO members (customer_id, join_date)
VALUES
('A', '2021-01-07'),
('B', '2021-01-09');
INSERT INTO sales (customer_id, order_date, product_id)
VALUES
('A', '2021-01-01', 1),
('A', '2021-01-01', 2),
('A', '2021-01-07', 2),
('A', '2021-01-10', 3),
('A', '2021-01-11', 3),
('A', '2021-01-11', 3),

('B', '2021-01-01', 2),
('B', '2021-01-02', 2),
('B', '2021-01-04', 1),
('B', '2021-01-11', 1),
('B', '2021-01-16', 3),
('B', '2021-02-01', 3),

('C', '2021-01-01', 3),
('C', '2021-01-01', 3),
('C', '2021-01-07', 3);
SELECT *
FROM menu;
SELECT *
FROM sales;

-- 1. What is the total amount each customer spent at the restaurant? 

SELECT
    s.customer_id,
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m
    ON s.product_id = m.product_id
GROUP BY s.customer_id;

-- 2. How many days has each customer visited the restaurant? 

SELECT
    customer_id,
    COUNT(DISTINCT order_date) AS days_visited
FROM sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?

SELECT
    s.customer_id,
    m.product_name
FROM sales s
JOIN (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM sales
    GROUP BY customer_id
) f
    ON s.customer_id = f.customer_id
    AND s.order_date = f.first_order_date
JOIN menu m
    ON s.product_id = m.product_id;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
    
    SELECT
    m.product_name,
    COUNT(*) AS times_purchased
FROM sales s
JOIN menu m
    ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY times_purchased DESC
LIMIT 1;

-- 5. Which item was the most popular for each customer? 
 
    WITH item_counts AS (
    SELECT
        s.customer_id,
        m.product_name,
        COUNT(*) AS times_purchased
    FROM sales s
    JOIN menu m
        ON s.product_id = m.product_id
    GROUP BY
        s.customer_id,
        m.product_name
) 
SELECT
    customer_id,
    product_name,
    times_purchased
FROM item_counts
WHERE times_purchased = (
    SELECT MAX(times_purchased)
    FROM item_counts ic
    WHERE ic.customer_id = item_counts.customer_id
);

-- 6. Which item was purchased first by the customer after they became a member?
 
SELECT
    s.customer_id,
    m.product_name
FROM sales s
JOIN members mem
    ON s.customer_id = mem.customer_id
JOIN menu m
    ON s.product_id = m.product_id
WHERE s.order_date = (
    SELECT MIN(s2.order_date)
    FROM sales s2
    WHERE s2.customer_id = s.customer_id
      AND s2.order_date >= mem.join_date
);

-- 7. Which item was purchased just before the customer became a member?
 
SELECT
    s.customer_id,
    m.product_name
FROM sales s
JOIN members mem
    ON s.customer_id = mem.customer_id
JOIN menu m
    ON s.product_id = m.product_id
WHERE s.order_date = (
    SELECT MAX(s2.order_date)
    FROM sales s2
    WHERE s2.customer_id = s.customer_id
      AND s2.order_date < mem.join_date
);

-- 8. What are the total items and amount spent for each member before they became a member?
 
SELECT
    s.customer_id,
    COUNT(*) AS total_items,
    SUM(m.price) AS total_spent
FROM sales s
JOIN members mem
    ON s.customer_id = mem.customer_id
JOIN menu m
    ON s.product_id = m.product_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id;

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have? 

SELECT
    s.customer_id,
    SUM(
        CASE
            WHEN m.product_name = 'sushi'
                THEN m.price * 20
            ELSE m.price * 10
        END
    ) AS total_points
FROM sales s
JOIN menu m
    ON s.product_id = m.product_id
GROUP BY s.customer_id;

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

SELECT
    s.customer_id,
    SUM(
        CASE
            WHEN s.order_date >= mem.join_date
             AND s.order_date < DATE_ADD(mem.join_date, INTERVAL 7 DAY)
            THEN
                CASE
                    WHEN m.product_name = 'sushi'
                        THEN m.price * 20 * 2
                    ELSE m.price * 10 * 2
                END

            WHEN m.product_name = 'sushi'
                THEN m.price * 20
            ELSE m.price * 10
        END
    ) AS total_points
FROM sales s
JOIN members mem
    ON s.customer_id = mem.customer_id
JOIN menu m
    ON s.product_id = m.product_id
WHERE s.order_date <= '2021-01-31'
GROUP BY s.customer_id;