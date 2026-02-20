## 1. WHERE vs HAVING

Think of filtering in SQL as a two-stage process.

* **WHERE** filters individual rows **before** grouping.
* **HAVING** filters grouped results **after** aggregation.

### Key Difference

* WHERE works on raw rows.
* HAVING works on aggregated groups.
* WHERE cannot use aggregate functions directly.
* HAVING can use aggregate functions like COUNT(), SUM(), AVG().

### Example

```sql
SELECT department, AVG(salary) AS avg_salary
FROM Employees
WHERE salary > 50000
GROUP BY department
HAVING AVG(salary) > 60000;
```

Explanation:

1. FROM → read Employees table.
2. WHERE salary > 50000 → remove employees earning 50k or less.
3. GROUP BY department → group remaining employees.
4. HAVING AVG(salary) > 60000 → keep departments with high average salary.

---

## 2. DELETE vs TRUNCATE vs DROP

All three remove data, but they differ in level and impact.

| Command  | What it Removes | Keeps Table Structure? | Can Use WHERE? | Rollback?             |
| -------- | --------------- | ---------------------- | -------------- | --------------------- |
| DELETE   | Selected rows   | Yes                    | Yes            | Yes (in most systems) |
| TRUNCATE | All rows        | Yes                    | No             | Usually No            |
| DROP     | Table + Data    | No                     | No             | No                    |

### Examples

```sql
DELETE FROM Students WHERE id = 10;
TRUNCATE TABLE Students;
DROP TABLE Students;
```

Simple idea:

* DELETE → precise and safer.
* TRUNCATE → fast full wipe.
* DROP → removes the entire table completely.

---

## 3. Logical Order of Execution in SQL

Even though we write:

SELECT ...
FROM ...
WHERE ...
GROUP BY ...
HAVING ...
ORDER BY ...

The SQL engine logically executes in this order:

1. FROM / JOIN
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY

Explanation:

* FROM → identify tables.
* WHERE → filter rows.
* GROUP BY → form groups.
* HAVING → filter groups.
* SELECT → choose columns and compute expressions.
* ORDER BY → sort final result.

This is why column aliases cannot be used in WHERE (because SELECT runs later).

---

## 4. COUNT(*) vs COUNT(column_name)

The difference is how NULL values are treated.

### COUNT(*)

* Counts every row in the result.
* Includes rows even if columns contain NULL.

### COUNT(column_name)

* Counts only rows where that column is NOT NULL.
* Ignores NULL values.

### Example

| id | grade |
| -- | ----- |
| 1  | 90    |
| 2  | NULL  |
| 3  | 85    |

```sql
SELECT COUNT(*), COUNT(grade)
FROM Students;
```

Result:

* COUNT(*) = 3
* COUNT(grade) = 2

Because one grade is NULL.

---

## 5. CHAR vs VARCHAR

Both store text, but they handle storage differently.

### CHAR(10) – Fixed Length

* Always reserves 10 characters.
* If we store "Cat", it becomes:

"Cat       "

(7 spaces added)

Storage used = 10 characters.

### VARCHAR(10) – Variable Length

* Uses only the needed space.
* If we store "Cat", it stores exactly:

"Cat"

Storage used = 3 characters (plus small internal length metadata).

### Conclusion

* Use CHAR for fixed-length values (like country codes).
* Use VARCHAR for variable-length text (like names or emails).
