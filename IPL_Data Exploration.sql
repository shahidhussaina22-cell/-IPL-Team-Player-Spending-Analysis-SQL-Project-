-- ====================================================================
-- PROJECT: IPL Player Valuation & Financial Analytics
-- DATABASE: IPL_TEAM_ANALYST
-- ====================================================================

USE IPL_TEAM_ANALYST;

-- ----------------------------------------------------------------    
-- Q1: Find the total spending on players for each team
-- ----------------------------------------------------------------    
SELECT 
    Team, 
    SUM(Price_in_cr) AS Total_Spending
FROM IPLPlayers
GROUP BY Team
ORDER BY Total_Spending DESC;


-- ----------------------------------------------------------------    
-- Q2: Find the top 3 highest-paid 'All-rounders' across all teams
-- ----------------------------------------------------------------    
SELECT TOP 3
    Player,
    Team,
    Role,
    Price_in_cr
FROM IPLPlayers
WHERE Role = 'All-Rounder'
ORDER BY Price_in_cr DESC;


-- ----------------------------------------------------------------    
-- Q3: Find the top 3 highest-paid 'All-rounders' for each team
-- ----------------------------------------------------------------    
SELECT * 
FROM (
    SELECT 
        Player,
        Price_in_cr,
        Role,
        Team,
        ROW_NUMBER() OVER (PARTITION BY Team ORDER BY Price_in_cr DESC) AS Player_Rank
    FROM IPLPlayers
    WHERE Role = 'All-rounder'
) t 
WHERE Player_Rank <= 3;


-- ----------------------------------------------------------------    
-- Q4: Find the highest-priced player in each team (Using CTE)
-- ----------------------------------------------------------------    
WITH CTE_MaxPrice AS (
    SELECT 
        Team, 
        MAX(Price_in_cr) AS Max_Price
    FROM IPLPlayers
    GROUP BY Team
)
SELECT 
    i.Team,
    i.Player,
    c.Max_Price AS Highest_Price
FROM IPLPlayers i 
JOIN CTE_MaxPrice c 
    ON i.Team = c.Team
WHERE i.Price_in_cr = c.Max_Price;


-- ----------------------------------------------------------------    
-- Q5: Rank players by price within each team and list top 2
-- ----------------------------------------------------------------    
WITH CTE_PriceRank AS (
    SELECT 
        Team,
        Player,
        Price_in_cr,
        ROW_NUMBER() OVER (PARTITION BY Team ORDER BY Price_in_cr DESC) AS Price_Rank
    FROM IPLPlayers
)
SELECT 
    Team,
    Player,
    Price_in_cr,
    Price_Rank  
FROM CTE_PriceRank
WHERE Price_Rank <= 2;


-- ----------------------------------------------------------------    
-- Q6: Side-by-side view of the 1st and 2nd most expensive players per team
-- ----------------------------------------------------------------    
WITH CTE_RankPivot AS (
    SELECT 
        Team,
        Player,
        Price_in_cr,
        ROW_NUMBER() OVER (PARTITION BY Team ORDER BY Price_in_cr DESC) AS Price_Rank
    FROM IPLPlayers
)
SELECT
    Team,
    MAX(CASE WHEN Price_Rank = 1 THEN Player END) AS Top_Player_1,
    MAX(CASE WHEN Price_Rank = 1 THEN Price_in_cr END) AS Price_1,
    MAX(CASE WHEN Price_Rank = 2 THEN Player END) AS Top_Player_2,
    MAX(CASE WHEN Price_Rank = 2 THEN Price_in_cr END) AS Price_2
FROM CTE_RankPivot
GROUP BY Team;


-- ----------------------------------------------------------------    
-- Q7: Calculate percentage contribution of each player to team total
-- ----------------------------------------------------------------    
SELECT 
    Team,
    Player,
    Price_in_cr,
    SUM(Price_in_cr) OVER (PARTITION BY Team) AS Total_Team_Spend,
    CAST((Price_in_cr * 100.0) / SUM(Price_in_cr) OVER (PARTITION BY Team) AS DECIMAL(10,2)) AS Pct_Contribution
FROM IPLPlayers;


-- ----------------------------------------------------------------    
-- Q8: Classify players into price brackets and count per team
-- ----------------------------------------------------------------    
WITH CTE_Bracket AS (
    SELECT 
        Team,
        Player,
        Price_in_cr,
        CASE 
            WHEN Price_in_cr > 15 THEN 'High (> 15 Cr)'
            WHEN Price_in_cr BETWEEN 5 AND 15 THEN 'Medium (5-15 Cr)'
            ELSE 'Low (< 5 Cr)'
        END AS Price_Bracket
    FROM IPLPlayers
)
SELECT 
    Team, 
    Price_Bracket, 
    COUNT(*) AS No_Of_Players
FROM CTE_Bracket
GROUP BY Team, Price_Bracket
ORDER BY Team, Price_Bracket;


-- ----------------------------------------------------------------    
-- Q9: Compare average price of Indian players vs. Overseas players
-- ----------------------------------------------------------------    
SELECT 
    'Indian Player' AS Player_Type,
    CAST((SELECT AVG(Price_in_cr) FROM IPLPlayers WHERE Type LIKE 'Indian%') AS DECIMAL(10,2)) AS Avg_Price
UNION ALL
SELECT 
    'Overseas Player' AS Player_Type,
    CAST((SELECT AVG(Price_in_cr) FROM IPLPlayers WHERE Type LIKE 'OVERSEA%') AS DECIMAL(10,2)) AS Avg_Price;


-- ----------------------------------------------------------------    
-- Q10: Identify players who earn more than their team's average price
-- ----------------------------------------------------------------    
WITH CTE_TeamAvg AS (
    SELECT 
        Team,
        Player,
        Price_in_cr,
        CAST(AVG(Price_in_cr) OVER (PARTITION BY Team) AS DECIMAL(10,2)) AS Team_Avg_Price
    FROM IPLPlayers
)
SELECT * 
FROM CTE_TeamAvg
WHERE Price_in_cr >= Team_Avg_Price
ORDER BY Team, Price_in_cr DESC;


-- ----------------------------------------------------------------    
-- Q11: Find the most expensive player for each role using a correlated subquery
-- ----------------------------------------------------------------    
SELECT 
    Player, 
    Team, 
    Role, 
    Price_in_cr
FROM IPLPlayers p
WHERE Price_in_cr = (
    SELECT MAX(Price_in_cr) 
    FROM IPLPlayers
    WHERE Role = p.Role
);