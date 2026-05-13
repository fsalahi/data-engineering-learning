-- Day 3

-- Window Function 
-- Question: Given a table "Employees" with columns "employee_id, department_id, salary"
-- rank employees by salary within each department
SELECT
    employee,
    department,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

-- Another version of this: Find the highest-paid employee in each department
WITH ranked_employees AS (
    SELECT
        employee,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
)

SELECT *
FROM ranked_employees
WHERE rn = 1;
