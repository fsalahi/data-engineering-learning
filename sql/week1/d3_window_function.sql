-- Day 3

-- Window Function 
-- Question: Given a table "Employees" with columns "employee_id, department_id, salary"
-- rank employees by salary within each department

-- lets make sample data for this
-- Create the table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    department_id INT,
    salary NUMERIC
);

-- Insert sample data
INSERT INTO Employees (employee_id, department_id, salary) VALUES
(1, 10, 5000),
(2, 10, 6000),
(3, 10, 6000),
(4, 20, 4000),
(5, 20, 7000),
(6, 20, 5000);

--Solution
SELECT
    employee_id,
    department_id,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;
-- Above query sequentially ranks when there is a tie.
-- what if we want to give the same rank?
SELECT
    employee_id,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;
-- The one above shares ranks for ties, but skips the next rank(s).
-- what if we want tied values share a rank, and the next rank is consecutive without gaps:
SELECT 
    employee_id,
    department_id,
    salary,
    DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM 
    employees;



-- Another version of this question: Find the highest-paid employee in each department
WITH ranked_employees AS (
    SELECT
        employee_id,
        department_id,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS rn
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE rn = 1;