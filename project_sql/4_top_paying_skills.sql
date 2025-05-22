/*
    💡 Question:
        What are the top 10 highest-paying skills required for Data Analyst roles
        based on average annual salary?

    📊 Insight:
        This query identifies which technical skills are associated with the highest
        average salaries for Data Analyst positions. It helps prioritize skill development
        based on earning potential.
*/

SELECT
    s.skills,
    round(avg(salary_year_avg),2) as avg_salary
FROM 
    job_postings_fact j 
INNER JOIN 
    skills_job_dim sj on j.job_id=sj.job_id
INNER JOIN
    skills_dim s on sj.skill_id=s.skill_id
WHERE
    job_title_short='Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    s.skills
ORDER BY
    avg_salary DESC
LIMIT 10;