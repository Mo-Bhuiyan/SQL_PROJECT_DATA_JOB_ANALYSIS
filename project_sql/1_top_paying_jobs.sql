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

-- above two queries are same results but different ways of joinined. The former is an old way, which is Comma Join + Where clause, which is basically the same as INNER JOIN
-- However in the former I did left join, so how did the two produce same results? Because every job posting has a corresponding company ID. There are no rows with missing values.
-- If there was, THEN they would yield different results. Here is proof none are missing.
-- I am doing a left join and asking if there is a company.id = null for basically any job posting row. If below is = 0 then there is 0 rows in job posting facts table where company ID is null meaning inner join and left join on company ID will be same 

SELECT COUNT(*) 
FROM job_postings_fact jp
LEFT JOIN company_dim cd ON jp.company_id = cd.company_id
WHERE cd.company_id IS NULL;