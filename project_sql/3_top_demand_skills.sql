-- count of remote job postings per skill
-- display top 5 skills by their demand in remote jobs
-- include SKILL ID, NAME, and count of postings requiring the skill

-- essentially what are the top 5 skills for remote jobs

WITH remote_job_skills AS (
SELECT
    skill_id,
    COUNT(*) AS skill_count-- how does it know which to count? isn't group by executed first?
FROM
    skills_job_dim AS s2j
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = s2j.job_id
WHERE
    job_postings.job_work_from_home = TRUE AND
    job_postings.job_title_short = 'Data Analyst'
    
GROUP BY
    skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM
    remote_job_skills
INNER JOIN skills_dim AS skills on skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5
;