//practise prob 8
SELECT job_title_short,
       job_location,
       job_via,
       job_posted_date ::DATE,
       salary_year_avg
FROM(
    SELECT *
    FROM january_jobs
    union ALL
    select*
    FROM february_jobs
    union ALL
    select*
    FROM march_jobs

) as quater1_job_postings
where salary_year_avg >70000 
and job_title_short='Data Analyst'
ORDER BY salary_year_avg DESC;