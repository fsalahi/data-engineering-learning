1. SQL order of execution:
FROM
JOIN
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
LIMIT
WHY? Filter as early as possible to increase effiency, agg func (such as avg, count(*), etc) only comes in having not in where, aliase of select cant be used in where as it hasn't reached the selection yet

2. JOINs
2.1. INNER: value of the key needs to exist in both tables, therefore it only keeps matching rows
2.2. LEFT: keeps everything from the left table


3. CTE 
WITH My_CTE_Name AS (
    -- This is your subquery
    SELECT column1, column2
    FROM table_name
    WHERE condition
)
-- This is your main query referencing the CTE
SELECT * 
FROM My_CTE_Name;

4. HAVING vs WHERE
WHERE: filters rows before grouping while HAVING filters grouped results. Basically, where is executed before group by, having executes after rows are grouped. (Also remember HAVING is only used in SELECT queries)

Example: Imagine an employees table. You want to see the average salary for each department, but only for active employees, and you only want to see departments where that average is over $50,000.
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    WHERE employment_status = 'active'   -- Step 1: Filter raw rows first
    GROUP BY department                  -- Step 2: Group the remaining rows
    HAVING AVG(salary) > 50000;          -- Step 3: Filter the resulting groups

5. CASE WHEN
    5.1. The standard structure requires CASE, WHEN, THEN, and END keywords.
    SELECT column_name,
        CASE 
            WHEN condition1 THEN result1
            WHEN condition2 THEN result2
            ELSE result3
        END AS alias_name
    FROM table_name;

    5.2. When to use it:
    - categorizing data (high, medium, low) -> see example 2 in d4_case_when.sql
    - data transformation (active -> inactive)
    - costum sorting (use CASE within an ORDER BY)
    - conditional aggregations () -> see example 1 in d4_case_when.sql

6. WINDOW FUNCTION
fundamental idea: perform calculation across related rows without collapsing them (unlike GROUP BY)
So, window -> the subset of rows that stay visible to the function:
    ... over (
        PARTITION BY ...
        ORDER BY ... --optional
    ) AS

what functions can we use before over?
usually: 
    ROW_NUMBER() -- assigns sequential row numbers
    RANK() --similar to row_number but handles ties diffrently -> skips numbers
    DENSE_RANK() --doesn't skip numbers
    AVG()
    SUM()
    LAG() --looks at previous row
    LEAD() --looks at next row
For more insight about ROW_NUMBER, RANK, AND DENSE_RANK go to
d3_window_function.sql and run the select queries.





