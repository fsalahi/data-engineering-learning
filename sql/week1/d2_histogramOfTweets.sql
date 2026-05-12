-- https://datalemur.com/questions/sql-histogram-tweets

-- first approach
SELECT
    tweet_counts.num_of_tweets,
    COUNT(*) AS users_num
FROM (
    SELECT
        user_id,
        COUNT(*) AS num_of_tweets
    FROM tweets
    GROUP BY user_id
) AS tweet_counts
GROUP BY tweet_counts.num_of_tweets;


-- improved approach (CTE)
WITH tweet_counts AS (
    SELECT
        user_id,
        COUNT(*) AS num_of_tweets
    FROM tweets
    GROUP BY user_id
)

SELECT
    num_of_tweets,
    COUNT(*) AS users_num
FROM tweet_counts
GROUP BY num_of_tweets
ORDER BY num_of_tweets;