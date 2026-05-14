-- Day 4

-- CASE WHEN 

-- Question1: Given a table "Matches" with columns "Season, 
-- HomeTeamID, HomeGoal, and AwayGoal", how would you 
-- calculate the total number of home wins and away wins
-- for a specific team (e.g., ID 8650) for each season?

-- lets make sample data
-- Create the table
CREATE TABLE Matches (
    Season VARCHAR(9),
    HomeTeamID INT,
    AwayTeamID INT,
    HomeGoal INT,
    AwayGoal INT
);

-- Insert sample data
INSERT INTO Matches (Season, HomeTeamID, AwayTeamID, HomeGoal, AwayGoal) VALUES
('2024-2025', 8650, 1001, 3, 1), -- Home Win
('2024-2025', 8650, 1002, 1, 2), -- Home Loss
('2024-2025', 1003, 8650, 0, 2), -- Away Win
('2024-2025', 1004, 8650, 1, 1), -- Away Draw
('2025-2026', 8650, 1003, 2, 0), -- Home Win
('2025-2026', 1001, 8650, 1, 3); -- Away Win
('2025-2026', 1005, 8650, 2, 3); -- Away Win

-- SELECT * FROM MATCHES;

-- Solution
SELECT 
    Season,
    SUM(CASE WHEN HomeTeamID = 8650 AND HomeGoal > AwayGoal THEN 1 ELSE 0 END) AS home_wins,
    SUM(CASE WHEN AwayTeamID = 8650 AND AwayGoal > HomeGoal THEN 1 ELSE 0 END) AS away_wins
FROM 
    Matches
WHERE 
    HomeTeamID = 8650 OR AwayTeamID = 8650
GROUP BY 
    Season
ORDER BY 
    Season DESC;


-- Question 2 (use CASE WHEN to categorize data): Given a table Employees with columns emp_id, 
-- emp_name, salary, and perf_rating (on a scale of 1 to 5), write a query to categorize 
-- each employee into one of the following Bonus Tiers:Tier 1 (Elite): Performance rating
-- is 5 AND salary is under $80,000.Tier 2 (High Performer): Performance rating is 4 or 5
--(and doesn't fit Tier 1).Tier 3 (Standard): Performance rating is 3.No Bonus: 
-- Performance rating is 1 or 2.Your query must return the emp_name, perf_rating, salary, 
-- and the calculated bonus_tier.

-- Sample data
CREATE TABLE EmployeesPerformance (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    perf_rating INT
);

INSERT INTO EmployeesPerformance (emp_id, emp_name, salary, perf_rating) VALUES
(1, 'Alice Smith', 75000, 5),   -- Should be Tier 1 (Rating 5, Salary < 80k)
(2, 'Bob Jones', 95000, 5),     -- Should be Tier 2 (Rating 5, but Salary >= 80k)
(3, 'Charlie Brown', 85000, 4), -- Should be Tier 2 (Rating 4)
(4, 'Diana Prince', 60000, 3),  -- Should be Tier 3 (Rating 3)
(5, 'Evan Wright', 50000, 2);   -- Should be No Bonus (Rating 2)


-- Solution
SELECT emp_name, salary, perf_rating, 
    CASE
        WHEN perf_rating = 5 AND salary < 80000 THEN 'Tier 1 (Elite)'
        WHEN perf_rating IN (4, 5) THEN 'Tier 2 (High Performer)'
        WHEN perf_rating = 3 THEN 'Tier 3 (Standard)'
        ELSE 'No Bonus'
    END AS bonus_tier
FROM EmployeesPerformance;