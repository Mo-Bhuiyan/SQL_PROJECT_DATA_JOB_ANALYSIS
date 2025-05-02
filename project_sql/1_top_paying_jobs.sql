/*
Question: What are the top-paying data analyst jobs?

-- Identify the top 10 highest-paying Data Analyst roles that are avaialble remotely.
-- Focuses on job postings with specified salaries (remove nulls)
-- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment 

*/

SELECT
    jp.job_id,
    cd.name,
    jp.job_title_short,
    jp.job_title,
    jp.job_location,
    jp.job_via,
    jp.salary_year_avg
FROM
    job_postings_fact jp, company_dim cd
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND jp.company_id = cd.company_id
    AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;

-- A different way, same answer

SELECT
    jp.job_id,
    cd.name,
    jp.job_title_short,
    jp.job_title,
    jp.job_location,
    jp.job_via,
    jp.salary_year_avg
FROM
    job_postings_fact jp
LEFT JOIN
    company_dim cd ON jp.company_id = cd.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;