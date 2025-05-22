-- 💡 Question:
-- What are the top 10 highest-paying Data Analyst jobs located in India,
-- and what specific skills are required for each of these roles?

-- 🧠 Explanation:
-- This two-part query is designed to help understand not just who the top-paying employers are,
-- but also what skills they expect from candidates.
-- 1. The CTE (Common Table Expression) `top_paying_jobs` selects the top 10 highest-paid
--    Data Analyst roles in India that have salary information available.
-- 2. The final SELECT statement joins this top 10 list with the skills tables
--    to reveal the required skills for each of those high-paying jobs.

-- 🔍 Step 1: Create a list of the top 10 highest-paying Data Analyst jobs in India
WITH top_paying_jobs AS (
    SELECT 
        job_id,                            -- Unique job identifier
        job_title,                         -- Full job title
        name AS company_name,             -- Name of the hiring company
        salary_year_avg                   -- Average annual salary for the role
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'  -- Filter for Data Analyst roles only
        AND job_location = 'India'        -- Restrict to roles based in India
        AND salary_year_avg IS NOT NULL   -- Exclude listings with missing salary data
    ORDER BY
        salary_year_avg DESC              -- Sort by highest salaries
    LIMIT 10                              -- Keep only the top 10 highest paying roles
)

-- 🔗 Step 2: Join with skills tables to list required skills for each top job
SELECT 
    top_paying_jobs.*,                    -- All job info from the top-paying CTE
    skills                                -- Skill required for each job
FROM 
    top_paying_jobs
INNER JOIN 
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;