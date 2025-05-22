/*
    💡 Question:
        What are the top 10 highest-paying Data Analyst job listings in India,
        including company, location, work schedule, and posting date?

    📊 Insight:
        This query provides a detailed view of premium Data Analyst opportunities in India,
        helping to identify top employers, preferred work formats, and recent high-paying job trends.
*/

SELECT 
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'India'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
