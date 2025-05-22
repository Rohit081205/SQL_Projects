-- 💡 Question:
-- What are the top 5 most in-demand skills for Data Analyst roles in India?

-- 🧠 Explanation:
-- This query identifies which technical skills are most frequently required for
-- Data Analyst job postings located in India. It works by:
-- 1. Joining the job postings with the associated skills using the junction table `skills_job_dim`.
-- 2. Filtering to include only jobs with the title 'Data Analyst' and located in 'India'.
-- 3. Grouping by each skill and counting how many times each appears.
-- 4. Sorting the results to highlight the most in-demand skills.
-- 5. Limiting to the top 5 results to keep the insights focused and digestible.

SELECT 
    s.skills,                                -- The name of the skill
    COUNT(sj.job_id) AS skill_demand_count   -- Number of Data Analyst jobs in India that require this skill
FROM 
    job_postings_fact j
INNER JOIN 
    skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN
    skills_dim s ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'       -- Only consider Data Analyst roles
    AND j.job_country = 'India'              -- Restrict to job postings in India
GROUP BY
    s.skills
ORDER BY
    skill_demand_count DESC                  -- Rank by highest demand
LIMIT 5;                                     -- Show only the top 5 most requested skills
