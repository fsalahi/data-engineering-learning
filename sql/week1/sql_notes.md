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
