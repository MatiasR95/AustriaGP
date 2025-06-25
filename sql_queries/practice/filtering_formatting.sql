/*Subfolder: Filtering/Formatting (5 Tasks)
Focus on `WHERE`, `HAVING`, string/date/number functions, formatting.
1. Task P1: Drivers by Nationality with Formatted Names
Objective: List unique drivers who raced in Austria, formatting names as “LASTNAME, Firstname” with their nationality.*/

SELECT
	UPPER(d.surname) + ', ' + d.forename AS Driver,
	d.nationality AS Nationality,
	COUNT(r.raceid) AS Total_Austrian_GP
FROM results r
JOIN drivers d ON d.driverId = r.driverId
JOIN races ra ON ra.raceId = r.raceId
WHERE ra.circuitId = 70
GROUP BY d.surname, d.forename, d.nationality
ORDER BY Total_Austrian_GP DESC;

/*2.Task P2: Races by Decade
    - Objective: Count races per decade (e.g., 1970s, 2010s) with formatted decade labels.*/

WITH AustrianGP AS(
SELECT
	CASE
		WHEN year BETWEEN 1950 and 1959 THEN '1950s'
		WHEN year BETWEEN 1960 and 1969 THEN '1960s'
		WHEN year BETWEEN 1970 and 1979 THEN '1970s'
		WHEN year BETWEEN 1980 and 1989 THEN '1980s'
		WHEN year BETWEEN 1990 and 1999 THEN '1990s'
		WHEN year BETWEEN 2000 and 2009 THEN '2000s'
		WHEN year BETWEEN 2010 and 2019 THEN '2010s'
		ELSE '2020s' END AS Decade,
	raceId
FROM races
WHERE circuitId = 70)
SELECT
	COUNT(*) AS Total_Race,
	Decade
FROM AustrianGP
GROUP BY Decade;

/*Task P3: Drivers with Recent DNFs
    -Objective: List drivers with DNFs (statusId ≠ 1) in the last 5 races (2018–2024), formatting DNF reasons.*/
SELECT
	UPPER(d.surname) + ', ' + d.forename AS Driver,
	year AS Season,
	s.status
FROM results r
JOIN races ra ON ra.raceId = r.raceId
JOIN drivers d ON d.driverId = r.driverId
JOIN status s ON s.statusId = r.statusId
WHERE ra.circuitId = 70 AND r.statusId <> 1 AND year BETWEEN 2018 AND 2024
ORDER BY year ASC;

/*4.Task P4: Qualifying Times in Seconds.
Objective: Convert fastest qualifying times (q3) to seconds for 2014–2024, filtering top 5 per race.*/
WITH q3Times AS(
SELECT
	TRY_CAST(PARSENAME(REPLACE(q3, ':', '.'), 3) AS INT) * 60 + -- minutes to seconds
    TRY_CAST(PARSENAME(REPLACE(q3, ':', '.'), 2) AS INT) +      -- seconds
    TRY_CAST(PARSENAME(REPLACE(q3, ':', '.'), 1) AS FLOAT) / 1000 AS TotalTimeInSeconds,
	ra.year AS Season
FROM qualifying q
JOIN races ra ON ra.raceId = q.raceId
WHERE ra.circuitId = 70 AND year BETWEEN 2014 AND 2024 AND q3 NOT LIKE '\N'),
Rank AS(
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY season ORDER BY TotalTimeInSeconds ASC) AS Rank
FROM q3Times)
SELECT
	TotalTimeInSeconds,
	Season
FROM Rank
WHERE Rank <= 5;

/*5.Task P5: Races with Specific Dates
    -Objective: List Austrian GPs held in June or July, formatting dates as “DD-MMM-YYYY”.*/ 
SELECT
	raceId,
	FORMAT(date, 'dd - MMM - yyyy') AS Date
FROM races
WHERE circuitId = 70 AND MONTH(date) IN(6, 7)
ORDER BY YEAR(date) ASC
    
