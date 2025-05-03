# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top paying jobs, in demand skills, and where high demand meets high salary in data analytics.

SQL queries? Check them out here: [project_sql_folder](/project_sql/)

# Background
My first SQL project led by https://www.youtube.com/watch?v=7mz73uXD9DA

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**
- **PostgresSQL**
- **Visual Studio Code**
- **Git & Github**

# The Analysis
### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles, I filted data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportuniries in the field.

```SQL
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
```
# What I learned
Throughout the adventure I supercharged my SQL toolkit.

# Conclusions

### Insights

5 main takeaways

1. TBD
2. TBD

### Closing Thoughts

This project really built up my skills in SQL