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
LIMIT 10;