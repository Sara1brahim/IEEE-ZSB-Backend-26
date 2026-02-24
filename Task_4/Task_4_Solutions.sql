-- 1). Combine Two Tables
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a
    ON p.personId = a.personId;



-- 2). Replace Employee ID With The Unique Identifier
SELECT 
    u.unique_id,
    e.name
FROM Employees e
LEFT JOIN EmployeeUNI u
    ON e.id = u.id;


-- 3). Customer Who Visited but Did Not Make Any Transactions
SELECT 
    v.customer_id,
    COUNT(*) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t
    ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id;


-- 4). Project Employees I
SELECT 
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
JOIN Employee e
    ON p.employee_id = e.employee_id
GROUP BY p.project_id;


-- 5). Sales Person
SELECT name
FROM SalesPerson
WHERE sales_id NOT IN (
    SELECT o.sales_id
    FROM Orders o
    JOIN Company c
      ON o.com_id = c.com_id
    WHERE c.name = 'RED'
);



-- 6. Rising Temperature
SELECT w1.id
FROM Weather w1
JOIN Weather w2
  ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
WHERE w1.temperature > w2.temperature;


-- 7). Average Time of Process per Machine
SELECT 
    s.machine_id,
    ROUND(AVG(e.timestamp - s.timestamp), 3) AS processing_time
FROM Activity s
JOIN Activity e
  ON s.machine_id = e.machine_id
 AND s.process_id = e.process_id
WHERE s.activity_type = 'start'
  AND e.activity_type = 'end'
GROUP BY s.machine_id;


-- 8). Students and Examinations
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COALESCE(e.cnt, 0) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN (
    SELECT 
        student_id,
        subject_name,
        COUNT(*) AS cnt
    FROM Examinations
    GROUP BY student_id, subject_name
) e
ON s.student_id = e.student_id
AND sub.subject_name = e.subject_name
ORDER BY s.student_id, sub.subject_name;


-- 9). Managers with at Least 5 Direct Reports
SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m
ON e.id = m.managerId;



-- 10). Confirmation Rate
SELECT 
    s.user_id,
    ROUND(
        COALESCE(AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END), 0), 
        2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id;

-- 11). Product Sales Analysis III
SELECT 
    s.product_id,
    s.year AS first_year,
    s.quantity,
    s.price
FROM Sales s
JOIN (
    SELECT product_id, MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
) AS first_sale
ON s.product_id = first_sale.product_id 
   AND s.year = first_sale.first_year;


-- 12). Market Analysis I
SELECT 
    u.user_id AS buyer_id,
    u.join_date,
    COUNT(o.order_id) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o
    ON u.user_id = o.buyer_id
   AND YEAR(o.order_date) = 2019
GROUP BY u.user_id, u.join_date;

