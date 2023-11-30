--Contest Leaderboard
https://www.hackerrank.com/challenges/contest-leaderboard/problem

select
    h.hacker_id,
    h.name,
    sum(s.score)
from    
    hackers as h
inner join
    (select
            hacker_id,
            challenge_id,
            max(score) as score
        from
            submissions
        group by 
            hacker_id,
            challenge_id) s
on h.hacker_id = s.hacker_id
group by
    h.hacker_id,
    h.name
having
    sum(s.score) <> 0
order by
    sum(s.score) desc,
    h.hacker_id

	
--The Pads
https://www.hackerrank.com/challenges/the-pads/problem

SELECT CONCAT(name,'(',SUBSTRING(Occupation, 1, 1),')') as name   
from Occupations
UNION
SELECT 
    CONCAT('There are a total of ',COUNT(*),' ',lower(occupation),'s.') job
FROM Occupations
Group by occupation
order by name;

--Top Percentile Fraud
https://platform.stratascratch.com/coding/10303-top-percentile-fraud

SELECT policy_num, state, claim_cost, fraud_score

FROM
(SELECT policy_num, state, claim_cost, fraud_score,
PERCENT_RANK() OVER(PARTITION BY state ORDER BY fraud_score desc) as r
FROM fraud_score) fraud_ranked

WHERE r <= 0.05

--Top 5 States With 5 Star Businesses
https://platform.stratascratch.com/coding/10046-top-5-states-with-5-star-businesses?code_type=1

SELECT
    state
    ,5stars
FROM
(SELECT state
    ,count(*) as 5stars
    ,DENSE_RANK() OVER(ORDER BY count(*) desc) as r
FROM
    yelp_business
WHERE
    stars = 5
GROUP BY State
ORDER BY
    5stars desc, state asc) ranked_states
where r < 5


--Highest Energy Consumption
https://platform.stratascratch.com/coding/10064-highest-energy-consumption

SELECT date, total_eng

FROM

(SELECT date, sum(consumption) as total_eng,
RANK() OVER(ORDER BY sum(consumption) DESC) as r

FROM
(SELECT * from fb_eu_energy
UNION ALL
SELECT * from fb_asia_energy
UNION ALL
SELECT * from fb_na_energy) fb_ww_energy

GROUP BY date) fb_ww_ranked

where r =1

--Apple Product Counts
https://platform.stratascratch.com/coding/10141-apple-product-counts

SELECT 
    language,
    COUNT(DISTINCT 
          CASE 
              WHEN e.device IN ('macbook pro','iphone 5s','ipad air') THEN e.user_id ELSE NULL
          END) AS n_apple_user,
    COUNT(DISTINCT e.user_id) AS n_total_users
FROM playbook_events e
JOIN playbook_users u USING(user_id)
GROUP BY u.language
ORDER BY n_total_users DESC


--Highest Salary in Department
https://platform.stratascratch.com/coding/9897-highest-salary-in-department

SELECT first_name, department, salary

FROM
(SELECT first_name, last_name, department, salary,
RANK() OVER(PARTITION BY department ORDER BY SALARY DESC) AS R
FROM employee) ranked_salary
where r = 1;