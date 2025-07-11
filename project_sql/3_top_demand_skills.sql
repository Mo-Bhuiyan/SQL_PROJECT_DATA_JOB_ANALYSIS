-- QUESTION: What is the most in demand skill for data analysts?
-- Similar to problem 7

SELECT
    skills,
    COUNT(skills_job_dim.job_id) as demand_count
FROM 
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_work_from_home IS TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5