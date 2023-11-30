--Ranking most successful game based off releasedate
SELECT 
  releasedate, 
  game, 
  totalearnings 
FROM 
  (
    SELECT 
      ReleaseDate, 
      game, 
      TotalEarnings, 
      RANK() OVER(
        PARTITION BY ReleaseDate 
        ORDER BY 
          TotalEarnings Desc
      ) AS r 
    FROM 
      `esports-eda.esports_earnings.GED` 
    ORDER BY 
      ReleaseDate ASC
  ) ranked 
WHERE 
  r = 1;
--Ranking top 10 highest earning games
SELECT 
  releasedate, 
  game, 
  totalearnings 
FROM 
  (
    SELECT 
      ReleaseDate, 
      game, 
      TotalEarnings, 
      RANK() OVER(
        PARTITION BY ReleaseDate 
        ORDER BY 
          TotalEarnings Desc
      ) AS r 
    FROM 
      `esports-eda.esports_earnings.GED` 
    ORDER BY 
      TotalEarnings DESC
  ) ranked 
WHERE 
  r = 1;
2.b
) alt 
SELECT 
  Game, 
  TotalEarnings 
FROM 
  table 
ORDER BY 
  totalearnings DESC 
LIMIT 
  10 --Top Earning games by GENRE
SELECT 
  genre, 
  game, 
  totalearnings 
FROM 
  (
    SELECT 
      genre, 
      game, 
      TotalEarnings, 
      RANK() OVER(
        PARTITION BY genre 
        ORDER BY 
          TotalEarnings Desc
      ) AS r 
    FROM 
      `esports-eda.esports_earnings.GED` 
    ORDER BY 
      TotalEarnings DESC
  ) ranked 
WHERE 
  r = 1;
--Most Players by Game
SELECT 
  Game, 
  TotalPlayers, 
  TotalTournaments 
FROM 
  `esports_earnings.GED` 
ORDER BY 
  TotalPlayers DESC --Most Tournaments by Game
SELECT 
  Game, 
  TotalPlayers, 
  TotalTournaments 
FROM 
  `esports_earnings.GED` 
ORDER BY 
  TotalTournaments DESC --Total Earnings in the Esports Scene by Year 
SELECT 
  Year, 
  SUM(Earnings) YearlyEarnings 
FROM 
  `esports_earnings.HED` 
GROUP BY 
  Year 
ORDER BY 
  Year ASC --Highest Earning Genres Yearly
SELECT 
  Year, 
  Genre, 
  MAX(Earnings) YearlyEarnings 
FROM 
  `esports_earnings.HED` A 
  JOIN `esports_earnings.GED` B ON A.game = b.game 
GROUP BY 
  Year, 
  Genre 
ORDER BY 
  Year DESC, 
  YearlyEarnings Desc --Earnings per year top 5 games (CSGO, Dota, LOL, FN, SC2) - window function on the Game possible
SELECT 
  CAST(Date AS date FORMAT 'MM/YYYY') Date, 
  Game, 
  SUM(Earnings) Earnings 
FROM 
  `esports-eda.esports_earnings.HED` 
WHERE 
  Game IN (
    SELECT 
      Game 
    FROM 
      `esports-eda.esports_earnings.GED` 
    ORDER BY 
      totalearnings DESC 
    LIMIT 
      5
  ) 
GROUP BY 
  Date, 
  Game 
ORDER BY 
  Game DESC --Tournaments per year top 5 games
SELECT 
  CAST(Date AS date FORMAT 'MM/YYYY') Date, 
  Game, 
  SUM(Tournaments) Tournaments 
FROM 
  `esports-eda.esports_earnings.HED` 
WHERE 
  Game IN (
    SELECT 
      Game 
    FROM 
      `esports_earnings.GED` 
    ORDER BY 
      TotalTournaments DESC 
    LIMIT 
      5
  ) 
GROUP BY 
  Date, 
  Game 
ORDER BY 
  Game DESC
