-- 1)Duplicate Emails
SELECT email AS Email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

-- 2)Delete Duplicate Emails
DELETE p1
FROM Person p1
JOIN Person p2
ON p1.email = p2.email
AND p1.id > p2.id;

-- 3)Nth Highest Salary
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  DECLARE offset_val INT;
  SET offset_val = N - 1;

  RETURN (
      SELECT DISTINCT salary
      FROM Employee
      ORDER BY salary DESC
      LIMIT 1 OFFSET offset_val
  );
END;

-- 4)Rank Scores
SELECT 
    s1.score,
    COUNT(DISTINCT s2.score) AS `rank`
FROM Scores s1
JOIN Scores s2
ON s1.score <= s2.score
GROUP BY s1.id, s1.score
ORDER BY s1.score DESC;

-- 5)Department Highest Salary
SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN (
        SELECT departmentId, MAX(salary) AS max_salary
        FROM Employee
        GROUP BY departmentId
     ) m
ON e.departmentId = m.departmentId
AND e.salary = m.max_salary
JOIN Department d
ON e.departmentId = d.id;ز
