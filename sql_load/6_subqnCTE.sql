//subq
SELECT *
FROM(SELECT*
     FROM job_postings_fact
     WHERE EXTRACT(MONTH FROM JOB_POSTED_DATE)=1
) AS january_jobs;

SELECT company_id,
       name as company_name
FROM company_dim
WHERE company_id IN (
    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention=TRUE
    ORDER BY company_id 
);


//CTE
WITH january_jobs as(
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs;

WITH company_job_count AS (
    SELECT company_id,
           COUNT(*) AS total_jobS
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name AS company_name,
       company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count 
ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC;


//practise prob 7
WITH remote_job_skills as(
    SELECT skill_id,
    count(*) as skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings
    ON skills_to_job.job_id=job_postings.job_id
    WHERE job_postings.job_work_from_home=TRUE
    and job_postings.job_title_short='Data Analyst'
    Group BY skill_id
)
    SELECT skills.skill_id,
    skills as skill_name,
    skill_count
    FROM remote_job_skills
    inner join skills_dim as skills
    on skills.skill_id=remote_job_skills.skill_id
    ORDER BY skill_count DESC
    LIMIT 5;

 
