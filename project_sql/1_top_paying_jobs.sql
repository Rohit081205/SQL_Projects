/*
    -- Retrieve the top 10 highest-paying 'Data Analyst' job postings 
    -- that are location-independent ('Anywhere') and have a non-null average salary.
    -- The query joins job postings with company details and orders results by salary (descending).
*/

SELECT 
        job_id,
        job_title,
        name as company_name,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date::DATE
FROM
        job_postings_fact
LEFT JOIN
        company_dim ON job_postings_fact.company_id=company_dim.company_id
WHERE
        job_title_short='Data Analyst' AND
        job_location='India' AND
        salary_year_avg IS NOT NULL
ORDER BY
        salary_year_avg DESC
LIMIT 10;-- 💡 Question:
-- What are the top 10 highest-paying Data Analyst job postings in India,
-- including details about the company, location, schedule type, and posting date?

-- 🧠 Explanation:
-- This query helps highlight the most lucrative Data Analyst opportunities in India.
-- It pulls job title, company info, salary, and other key job details,
-- and ranks them by the highest annual average salary.
-- Useful for job market analysis or guiding aspiring analysts on where the top pay is.

SELECT 
    job_id,                                -- Unique job identifier
    job_title,                             -- Full job title (not just the short version)
    name AS company_name,                  -- Name of the hiring company
    job_location,                          -- Location of the job
    job_schedule_type,                     -- Work schedule (e.g., full-time, contract)
    salary_year_avg,                       -- Average annual salary
    job_posted_date::DATE                  -- Casting to date for cleaner formatting
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'       -- Focus only on Data Analyst roles
    AND job_location = 'India'             -- Restricted to jobs located in India
    AND salary_year_avg IS NOT NULL        -- Exclude jobs without salary data
ORDER BY
    salary_year_avg DESC                   -- Sort by highest salaries first
LIMIT 10;                                  -- Limit to top 10 highest-paying listings
