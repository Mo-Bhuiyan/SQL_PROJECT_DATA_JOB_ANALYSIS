-- QUESTION: What are the most optimal skill to learn?
-- optimal = high demand AND high paying

WITH skills_demand AS

(    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) as demand_count
    FROM 
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_work_from_home IS TRUE
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), 

average_salary AS (
    SELECT
        skills_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM 
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home IS TRUE
    GROUP BY
        skills_dim.skill_id
)


SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.average_salary
FROM
    skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25
;
-- rewriting above query

SELECT
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg),0) as average_salary,
    count(*) as demand_count
FROM
    job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL -- can not use average salary, since that column is created AFTER where clause is executed I believe
    AND jpf.job_location = 'Anywhere'
GROUP BY
    sd.skills
HAVING
    count(sjd.job_id) > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25

-- Rewriting above because in having clause I am still a bit tripped up how andd when it works. So I am I believe just showing the work having clause is doing in the background to see what it is filtering for. Old note: VS HAVING count(*) > 10 where it would count most number of rows for any column even if that row has null. However by specfiying a column, it will look at the column and only count where 

SELECT
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg),0) as average_salary,
    count(*) as demand_count,
    CASE
        WHEN COUNT(*) > 10 THEN 'TRUE'
        ELSE 'FALSE'
    END AS demand_count_all_grt_10,
    CASE
        WHEN COUNT(jpf.job_id) > 10 THEN 'TRUE'
        ELSE 'FALSE'
    END AS demand_count_job_id_grt_10
FROM
    job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL -- can not use average salary, since that column is created AFTER where clause is executed I believe
    AND jpf.job_location = 'Anywhere'
GROUP BY
    sd.skills
HAVING
    count(sjd.job_id) > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25

-- now if there were some null values in job_id then job_id select statement would show some false if I took off the limit. However because every instance of a skill is linked to a job_id both will yield same results...
/* 

in essence, Having isn’t filtering on the aggregated results 
but rather respecting the groups and if I need to do another aggregation 
it will do it by the groups in the background (in terms of calculation)
and further refine my results. 

*/