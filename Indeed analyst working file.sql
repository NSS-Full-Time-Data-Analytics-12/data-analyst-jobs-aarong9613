--How many rows are in the data_analyst_jobs table?
-- 1793
--Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT (10);

--How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT 
	COUNT (CASE WHEN location = 'TN' THEN '1'  END) AS Tennessee,
	COUNT (CASE WHEN location = 'KY' THEN '1' END) AS Kentucky
FROM data_analyst_jobs;

--How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count >=500 and review_count <=1000;

--Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?
SELECT AVG (star_rating) AS avg_rating, location AS state
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating;

--Nevada has the highest avg_rating
--Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT DISTINCT title
FROM data_analyst_jobs;

--There are 881 unique job titles.
--How many unique job titles are there for California companies?
SELECT
	COUNT (DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

--Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT AVG(star_rating) AS avg_star_rating, company,
	COUNT(company) AS company_count
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company;

--Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT AVG(star_rating) AS avg_star_rating, company,
	COUNT(company) AS company_count
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_star_rating DESC;
-- General Motors through Kaiser Permanente has the highest avg_star_rating at 4.199
--Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT
	COUNT (DISTINCT title) AS unique_jobs
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst';
--How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT *
	--COUNT (DISTINCT title) AS not_Analyst_or_Analytics
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%';
--**BONUS:**
--You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
--Disregard any postings where the domain is NULL. 
--Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
--Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
SELECT domain, days_since_posting
FROM data_analyst_jobs
WHERE days_since_posting > 21 AND skill = 'SQL' AND domain IS NOT NULL
GROUP BY domain, days_since_posting
ORDER BY days_since_posting DESC
--GOOD JOB