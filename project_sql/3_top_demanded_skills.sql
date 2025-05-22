/*
    💡 Question:
        Which are the top 5 most in-demand skills for Data Analyst roles in India?

    📊 Insight:
        This query highlights the most frequently requested skills for Data Analyst jobs
        in India, helping to focus learning efforts on what employers value most.
*/

SELECT 
    s.skills,
    COUNT(sj.job_id) AS skill_demand_count
FROM 
    job_postings_fact j
INNER JOIN 
    skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN
    skills_dim s ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.job_country = 'India'
GROUP BY
    s.skills
ORDER BY
    skill_demand_count DESC
LIMIT 5;