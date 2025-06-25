/*Historical/Colapinto Queries (6 Tasks)
1.Task H1: Historical Winners
    -Objective: List top 5 drivers by wins, 1970–2024.*/

SELECT TOP 5
	SUM(CASE WHEN r.positionorder = 1 THEN 1 ELSE 0 END) AS Total_Austrian_Wins,
	d.forename + ' ' + d.surname AS Driver
FROM results r
JOIN races ra ON ra.raceId = r.raceId
JOIN drivers d ON d.driverId = r.driverId
WHERE ra.circuitId = 70
GROUP BY d.surname, d.forename
ORDER BY Total_Austrian_Wins DESC;

/*2.Task H2: Dominant Constructors by Wins
    - Objective: List top 5 constructors by Wins, 1970–2024*/

SELECT TOP 5
	SUM(CASE WHEN r.positionorder = 1 THEN 1 ELSE 0 END) AS Total_Austrian_Wins,
	c.name AS Constructor
FROM results r
JOIN races ra ON ra.raceId = r.raceId
JOIN constructors c ON c.constructorId = r.constructorId
WHERE ra.circuitId = 70
GROUP BY c.name
ORDER BY Total_Austrian_Wins DESC;

/*3.Task H3: Top 5 Pole Positions (2004–2024)
    - Objective: List top 5 drivers by poles, 2004–2024.*/

SELECT TOP 5
	d.forename + ' ' + d.surname AS Driver,
	SUM(CASE WHEN q.position = 1 THEN 1 ELSE 0 END) AS Total_Poles
FROM qualifying q
JOIN races ra ON ra.raceId = q.raceId
JOIN drivers d ON d.driverId = q.driverId
WHERE ra.circuitId = 70 AND ra.year BETWEEN 2004 AND 2024
GROUP BY d.forename, d.surname
ORDER BY Total_Poles DESC;

/*4. Task J1: Overtaking Frequency by Season
    - Objective: Calculate average position changes per season, 2014–2024.*/

SELECT
	year AS Season,
	AVG(ABS(CAST(grid AS FLOAT)- positionOrder)) AS AVG_Position_Changes
FROM results r
JOIN races ra ON ra.raceId = r.raceId
WHERE ra.circuitId = 70 AND year BETWEEN 2014 AND 2024 AND r.grid > 0
    AND r.positionOrder > 0
GROUP BY year
ORDER BY year;

/*5. Task J2: Pole-to-Win Rate
    - Objective: Calculate % of races where pole-sitter wins.*/
WITH Total_P1_Winners AS(
SELECT
	COUNT(DISTINCT r.raceId) AS Total_Races,
	SUM(CASE WHEN r.grid = r.positionOrder THEN 1 ELSE 0 END) AS Total_Pole_winner
FROM results r
JOIN races ra ON ra.raceId = r.raceId
WHERE ra.circuitId = 70 AND r.grid = 1)
SELECT
	ROUND((CAST(Total_Pole_winner as float) / Total_Races) * 100,1) AS Pole_To_Win_Ratio
FROM Total_P1_Winners;

/*6.Task C1/C2: Points Probability and Position Dynamics
    - Objective:
        - C1: % of races where grids 1–10 score points (top 10), 2014–2024.*/
WITH TotalPointsRaces AS(
SELECT
	r.grid AS GridPosition,
	SUM(CASE WHEN r.positionorder <= 10 THEN 1 ELSE 0 END) AS TotalPointsRaces,
	COUNT(DISTINCT r.raceId) AS TotalRaces
FROM results r
JOIN races ra ON ra.raceId = r.raceId
WHERE ra.circuitId = 70 AND year BETWEEN 2014 AND 2024 AND r.grid > 0
GROUP BY r.grid)
SELECT
	GridPosition,
	TotalPointsRaces,
	ROUND((CAST(totalpointsraces as float) / TotalRaces) * 100,1) AS Points_Probability
FROM TotalPointsRaces;

/*C2:Gain probability (% races where grid > positionOrder) 
and average position gain (grid - positionOrder) for grids 1–10, 2014–2024.*/

SELECT
    r.grid AS GridPosition,
    -- Count races where position improved
    SUM(CASE WHEN r.grid > r.positionOrder THEN 1 ELSE 0 END) AS Gained_Position_Races,
    -- Calculate % of races with gains
    ROUND((SUM(CASE WHEN r.grid > r.positionOrder THEN 1 ELSE 0 END) / CAST(COUNT(DISTINCT r.raceId) AS FLOAT)) * 100, 1) AS Gain_Probability,
    -- Average position change (positive = gain)
    ROUND(AVG(CAST(r.grid AS FLOAT) - CAST(r.positionOrder AS FLOAT)),1) AS AVGPositionGain
FROM results r
JOIN races ra ON ra.raceId = r.raceId
WHERE ra.circuitId = 70
 AND ra.year BETWEEN 2014 AND 2024 AND r.grid > 0 AND r.positionOrder > 0
GROUP BY r.grid
ORDER BY GridPosition ASC;

SELECT
	COUNT(DISTINCT raceId)
FROM races
WHERE circuitId = 70
