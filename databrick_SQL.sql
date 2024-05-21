--Create temporary view
df_filtered.createOrReplaceTempView("clinicaltrial")

-- Question 1: Number of Studies in the dataset
SELECT COUNT(DISTINCT `Id`) AS distinct_studies FROM clinicaltrial

-- Question 2: Types of studies and their frequencies

SELECT `Study Type`, COUNT(*) AS frequency 
FROM clinicaltrial 
GROUP BY `Study Type` 
ORDER BY frequency DESC

-- Question 3: Top 5 conditions with frequencies
SELECT `Conditions`, COUNT(*) AS frequency 
FROM clinicaltrial 
GROUP BY `Conditions` 
ORDER BY frequency DESC 
LIMIT 5

--Question 4: Top 10 most common sponsors that are not phramaceutical 
SELECT `Sponsor`, COUNT(*) AS trials 
FROM clinicaltrial 
WHERE `Sponsor` NOT IN (SELECT `Parent_Company` FROM pharmacy_dataset) 
GROUP BY `Sponsor` 
ORDER BY trials DESC 
LIMIT 10


-- Question 5: Plot number of completed studies for each month in 2023
SELECT MONTH(`Completion Date`) AS month, COUNT(*) AS num_completed
FROM clinicaltrial
WHERE YEAR(`Completion Date`) = 2023
GROUP BY month
ORDER BY month

-- further analysis 
SELECT `Study Type`, AVG(CAST(`Enrollment` AS INT)) AS avg_enrollment
FROM clinicaltrial
GROUP BY `Study Type`
ORDER BY avg_enrollment DESC

-- further analysis 
SELECT `Collaborators`, COUNT(*) AS total_collaborations
FROM clinicaltrial
WHERE `Collaborators` IS NOT NULL
GROUP BY `Collaborators`
ORDER BY total_collaborations DESC
LIMIT 5