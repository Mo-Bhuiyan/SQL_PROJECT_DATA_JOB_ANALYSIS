/*

Question: What skills are required for the top-paying data analyst jobs?
Why: Highlight the top paying opportunities for Data Analysts, offering insights into employment opportunities

*/

WITH top_paying_jobs AS (

    SELECT
        jp.job_id,
        cd.name,
        jp.job_title,
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
    LIMIT 10

)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

-- save results as CSV, then ask CHATGPT to provide insights on skills column for this top 10 data analysts roles