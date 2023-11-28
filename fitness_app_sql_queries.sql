##Code to calculate total sums of each respective area

SELECT 
  Steps.Time, 
  SUM(HourlyCalories) TotalCalories, 
  Sum(StepTotal) TotalSteps, 
  ROUND(
    Sum(AverageIntensity), 
    2
  ) TotalIntensity 
FROM 
  `project-350003.fitness.hourlyCalories_merged` Calories 
  JOIN `project-350003.fitness.hourlySteps_merged` Steps ON Steps.Time = Calories.Time 
  AND Steps.Id = Calories.Id 
  AND Steps.Date = Calories.Date 
  JOIN `project-350003.fitness.hourlyIntensities_merged` Intensity ON Steps.Time = Intensity.Time 
  AND Steps.Id = Intensity.Id 
  AND Steps.Date = Intensity.Date 
GROUP BY 
  Steps.Time 
ORDER BY 
  TotalCalories DESC

##Code to calculate total averages of each respective area // JOINING the hourlySteps and hourlyIntensities charts together to provide deeper analysis
SELECT Steps.Time,
       SUM(HourlyCalories) TotalCalories,
       Sum(StepTotal) TotalSteps,
       ROUND(Sum(AverageIntensity), 2) TotalIntensity
FROM `project-350003.fitness.hourlyCalories_merged` Calories
JOIN `project-350003.fitness.hourlySteps_merged` Steps ON Steps.Time = Calories.Time
AND Steps.Id = Calories.Id
AND Steps.Date = Calories.Date
JOIN `project-350003.fitness.hourlyIntensities_merged` Intensity ON Steps.Time = Intensity.Time
AND Steps.Id = Intensity.Id
AND Steps.Date = Intensity.Date
GROUP BY Steps.Time
ORDER BY TotalCalories DESC

##Sleep per night

SELECT EXTRACT(DAYOFWEEK
               FROM SleepDay)SleepDay,
       COUNT(SleepDay)days_recorded,
       ROUND(AVG(TotalTimeInBed-TotalMinutesAsleep), 2) AS AVGDFInBedVsSleeping,
       ROUND(AVG(TotalMinutesAsleep / 60), 2) AS AverageSleepPerNight
FROM `project-350003.fitness.sleepDay_merged`
GROUP BY SleepDay
ORDER BY AVGDFInBedVsSleeping DESC

SELECT EXTRACT(DAYOFWEEK
               FROM ActivityDate) AS DayOfWeek,
       AVG(VeryActiveMinutes)VeryActive,
       AVG(FairlyActiveMinutes)Fairly,
       AVG(LightlyActiveMinutes)Lightly,
       AVG(SedentaryMinutes)Sedentary,
       AVG(TotalMinutesAsleep)SleepyTime
FROM `project-350003.fitness.dailyActivity_merged` dailyActivity
LEFT JOIN `project-350003.fitness.sleepDay_merged` Sleep ON dailyActivity.id = Sleep.id
AND dailyActivity.ActivityDate = Sleep.SleepDay
GROUP BY DayOfWeek
ORDER BY DayofWeek


## Joining together users who submitted DATA
FOR activity levels AS well AS sleep DATA
FOR that same DAY
SELECT dA.ActivityDate,
       dA.Id,
       SUM(VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes+SedentaryMinutes)ActivityLevel,
       SUM(s.TotalMinutesAsleep)TimeSpentAsleeping
FROM `project-350003.fitness.dailyActivity_merged` dA
INNER JOIN `project-350003.fitness.sleepDay_merged` s ON dA.id = s.id
AND dA.ActivityDate = s.SleepDay
GROUP BY dA.ActivityDate,
         dA.Id
		 
