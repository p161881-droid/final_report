-- It is better to run these queries one by one. I got an error when running the whole file at once.

-- Query 1: Data size and missing values ---------------------------------
SELECT 
COUNT(*) AS total_rows,
SUM(CASE WHEN column281 IS NULL THEN 1 ELSE 0 END) AS null_target,
SUM(CASE WHEN column51 IS NULL OR column52 IS NULL OR column53 IS NULL THEN 1 ELSE 0 END) AS null_comments
FROM blogdata_train;

-- Query 2: Target variable distribution ----------------------------------
SELECT 
AVG(column281) AS avg_target,
MIN(column281) AS min_target,
MAX(column281) AS max_target,
SUM(CASE WHEN column281 = 0 THEN 1 ELSE 0 END) AS zero_target_count,
COUNT(*) AS total_count,
ROUND(SUM(CASE WHEN column281 = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS zero_percentage
FROM blogdata_train;

-- Query 3: Outlier detection -------------------------------------------
SELECT 
SUM(CASE WHEN column51 < 0 THEN 1 ELSE 0 END) AS neg_comments_51,
SUM(CASE WHEN column56 < 0 THEN 1 ELSE 0 END) AS neg_links_56,
SUM(CASE WHEN column51 > 500 THEN 1 ELSE 0 END) AS extreme_comments,
SUM(CASE WHEN column62 <= 0 THEN 1 ELSE 0 END) AS zero_or_neg_post_length
FROM blogdata_train;

-- Query 4: Parent page comments ------------------------------------------
SELECT 
AVG(column278) AS avg_min_parent_comments,
AVG(column279) AS avg_max_parent_comments,
AVG(column280) AS avg_avg_parent_comments
FROM blogdata_train;
