# SQL Concepts Research

## 1. UNION vs UNION ALL

### Duplicate Handling
- **UNION**: Removes duplicate rows from the combined result set. Only distinct rows appear.
- **UNION ALL**: Keeps all rows from both result sets, including duplicates.

### Performance
- **UNION**: Slower, because the database has to sort and remove duplicates.
- **UNION ALL**: Faster, no extra work to remove duplicates.

---

## 2. Subquery vs JOIN

### Why choose JOIN over Subquery
- **Performance**: Joins are generally more efficient, especially on large tables, because the database can optimize joins better than subqueries.
- **Readability**: Joins often make the query easier to read and maintain.
- **Flexibility**: Joins allow fetching related data from multiple tables in a single step, while subqueries might require multiple passes.
- **Index Usage**: Joins can leverage indexes more effectively, improving query speed in production environments.

