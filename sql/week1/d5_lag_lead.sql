-- The Scenario 1:
-- You are analyzing daily stock prices or asset values for a financial portfolio. You want to detect trends by comparing today's closing price with yesterday's price and tomorrow's price.
-- The Question: Given a table StockPrices with columns ticker, trade_date, and close_price, write a single query that displays the following for every day:
-- 1) The current day's closing price. 2) The Previous Day's closing price (using LAG). 3)The Next Day's closing price (using LEAD). 4) The Daily Change Amount (Current Price minus Previous Day's Price).

-- Sample data
CREATE TABLE StockPrices (
    ticker VARCHAR(10),
    trade_date DATE,
    close_price NUMERIC(10, 2),
    PRIMARY KEY (ticker, trade_date)
);

INSERT INTO StockPrices (ticker, trade_date, close_price) VALUES
('AAPL', '2026-05-11', 175.00),
('AAPL', '2026-05-12', 178.50),
('AAPL', '2026-05-13', 176.20),
('AAPL', '2026-05-14', 180.00),
('GOOG', '2026-05-11', 140.00),
('GOOG', '2026-05-12', 139.10),
('GOOG', '2026-05-13', 142.50),
('GOOG', '2026-05-14', 145.00);

-- SELECT * FROM StockPrices;

-- Solution
SELECT ticker, trade_date, close_price,
    LAG(close_price) OVER (
        PARTITION BY ticker
        ORDER BY trade_date
    ) AS prev_price,
    LEAD(close_price) OVER (
        PARTITION BY ticker
        ORDER BY trade_date
    ) AS next_price,
close_price - (LAG(close_price) OVER (ORDER BY trade_date)) AS daily_change
FROM StockPrices
ORDER BY ticker;

-- Follow up question: how to avoid nulls?
SELECT ticker, trade_date, close_price,
    -- If no previous row exists, use the current close_price
    LAG(close_price, 1, close_price) OVER ( -- Do you remember what is parameter 1 here? ;) 
        PARTITION BY ticker
        ORDER BY trade_date
    ) AS prev_price,
    -- If no next row exists, use 0.00 as a placeholder
    LEAD(close_price, 1, 0) OVER ( -- Do you remember what is parameter 1 here? ;)
        PARTITION BY ticker
        ORDER BY trade_date
    ) AS next_price,
close_price - (LAG(close_price) OVER (ORDER BY trade_date)) AS daily_change
FROM StockPrices
ORDER BY ticker;
