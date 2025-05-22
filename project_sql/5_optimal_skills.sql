/*
    💡 Question:
        Which remote-friendly Data Analyst skills are both in high demand and
        associated with high average salaries?

    📊 Insight:
        This query ranks the most in-demand skills for remote Data Analyst roles,
        filtered to only include those appearing in more than 25 job listings.
        It also cross-references each skill with the overall average salary where it appears,
        helping to identify skills that offer the best mix of demand and earning potential.
*/

WITH skills_demand AS
(
    SELECT
        sj.skill_id, 
        s.skills,
        COUNT(sj.job_id) AS skill_demand_count
    FROM 
        job_postings_fact j
    INNER JOIN 
        skills_job_dim sj ON j.job_id = sj.job_id
    INNER JOIN
        skills_dim s ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
        AND job_work_from_home='True'
    GROUP BY
        sj.skill_id,
        s.skills
),
average_salary AS
(
    SELECT
        sj.skill_id,
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
        sj.skill_id,
        s.skills
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skill_demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN 
    average_salary ON skills_demand.skill_id=average_salary.skill_id
WHERE
    skill_demand_count>25
ORDER BY
    avg_salary DESC,
    skill_demand_count DESC
LIMIT 25;