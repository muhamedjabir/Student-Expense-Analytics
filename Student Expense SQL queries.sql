CREATE DATABASE personal_expense_tracker;
USE personal_expense_tracker;



--  Create Table -- 

CREATE TABLE expenses (
    `Date` DATE,                -- Stores expense date
    Food INT,                   -- Food expense amount
    Transport INT,              -- Transport expense amount
    Other_expense INT,          -- Other category expenses
    Description TEXT,           -- Expense description
    Amount INT                  -- Total expense for the day
);

-- View table data --
SELECT * FROM expenses;



-- 3️⃣ Total Spending + Category %

SELECT 
    SUM(Food) AS Total_Food,                          -- Total food expenses
    SUM(Transport) AS Total_Transport,                -- Total transport expenses
    SUM(Other_expense) AS Total_Other,                -- Total other expenses
    SUM(Amount) AS Grand_Total,                       -- Overall spending
    ROUND(SUM(Food) * 100 / SUM(Amount),2) AS Food_Percentage,
    ROUND(SUM(Transport) * 100 / SUM(Amount),2) AS Transport_Percentage,
    ROUND(SUM(Other_expense) * 100 / SUM(Amount),2) AS Other_Percentage
FROM expenses;



-- Monthly Spending Report

SELECT 
    YEAR(`Date`) AS Year,                             
    MONTH(`Date`) AS Month,                           
    SUM(Amount) AS Monthly_Total                     
FROM expenses
GROUP BY YEAR(`Date`), MONTH(`Date`)
ORDER BY YEAR(`Date`), MONTH(`Date`);



-- Highest Expense Day

SELECT 
    `Date`,                                           -- Date
    SUM(Amount) AS Total_Spent                        -- Total spent on that date
FROM expenses
GROUP BY `Date`
ORDER BY Total_Spent DESC
LIMIT 1;



-- 6️⃣ Average Daily Spending

SELECT 
    ROUND(AVG(Amount), 2) AS Avg_Daily_Spending
FROM expenses;


-- Top 5 Highest Expense Records

SELECT *
FROM expenses
ORDER BY Amount DESC
LIMIT 5;



-- Category Ranking (Highest to Lowest) --

SELECT 'Food' AS Category, SUM(Food) AS Total FROM expenses
UNION ALL
SELECT 'Transport', SUM(Transport) FROM expenses
UNION ALL
SELECT 'Other Expense', SUM(Other_expense) FROM expenses
ORDER BY Total DESC;


-- Monthly Category Breakdown --
SELECT 
    YEAR(`Date`) AS Year,
    MONTH(`Date`) AS Month,
    SUM(Food) AS Total_Food,
    SUM(Transport) AS Total_Transport,
    SUM(Other_expense) AS Total_Other
FROM expenses
GROUP BY YEAR(`Date`), MONTH(`Date`)
ORDER BY Year, Month;


-- Month with Highest Spending

SELECT 
    YEAR(`Date`) AS Year,
    MONTH(`Date`) AS Month,
    SUM(Amount) AS Monthly_Total
FROM expenses
GROUP BY YEAR(`Date`), MONTH(`Date`)
ORDER BY Monthly_Total DESC
LIMIT 1;



-- Create View for Monthly Summary --

CREATE VIEW monthly_summary AS
SELECT 
    YEAR(`Date`) AS Year,
    MONTH(`Date`) AS Month,
    SUM(Amount) AS Monthly_Total
FROM expenses
GROUP BY YEAR(`Date`), MONTH(`Date`);

-- View the summary -- 
SELECT * FROM monthly_summary;