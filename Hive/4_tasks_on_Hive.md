## I used Hive scripts to run 4 tasks for basic statistics.
First,i upload table in ambari's Hive View.

<img width="1237" height="648" alt="屏幕截图 2026-06-27 201956" src="https://github.com/user-attachments/assets/76c6fce4-1589-45b5-a2bf-ad85401ea2a9" />

## dataset overview

Then I run this query to Check dataset size and missing value

```sql
SELECT 
COUNT(*) AS total_rows,
SUM(CASE WHEN column281 IS NULL THEN 1 ELSE 0 END) AS null_target,
SUM(CASE WHEN column51 IS NULL OR column52 IS NULL OR column53 IS NULL THEN 1 ELSE 0 END) AS null_comments
FROM blogdata_train
```
<img width="785" height="493" alt="屏幕截图 2026-06-27 214815" src="https://github.com/user-attachments/assets/c93caa64-072b-4f9f-8de5-dbe7891e95da" />

The dataset has 52397 samples. The target variable and comment features have no missing values. The data is complete.

## Target Variable Distribution

Then I run a query to check the target variable:

```sql
SELECT 
AVG(column281) AS avg_target,
MIN(column281) AS min_target,
MAX(column281) AS max_target,
SUM(CASE WHEN column281 = 0 THEN 1 ELSE 0 END) AS zero_target_count,
COUNT(*) AS total_count,
ROUND(SUM(CASE WHEN column281 = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS zero_percentage
FROM blogdata_train
```

<img width="848" height="542" alt="屏幕截图 2026-06-27 215334" src="https://github.com/user-attachments/assets/9231d344-f768-489e-8b57-7344b8f431ae" />

The average of the target variable is 6.76. The minimum is 0 and the maximum is 1424. There are 33559 samples with zero comments, which is 64.05% of the total. This means more than 60% of blog posts got no comments in the next 24 hours. The distribution is very skewed. A few popular posts got many comments. This is a zero-inflated problem.


## Outlier Detection
After that, I do outlier detection:

```sql
SELECT 
SUM(CASE WHEN column51 < 0 THEN 1 ELSE 0 END) AS neg_comments_51,
SUM(CASE WHEN column56 < 0 THEN 1 ELSE 0 END) AS neg_links_56,
SUM(CASE WHEN column51 > 500 THEN 1 ELSE 0 END) AS extreme_comments,
SUM(CASE WHEN column62 <= 0 THEN 1 ELSE 0 END) AS zero_or_neg_post_length
FROM blogdata_train
```

<img width="604" height="245" alt="屏幕截图 2026-06-27 220513" src="https://github.com/user-attachments/assets/2afc7d12-38a0-4cd9-950f-b78aa4a9e188" />

No negative values were found in comment and link features. The data is logically consistent. However, 643 samples have more than 500 total comments. These are extreme values, about 1.23% of the data. Also, 12750 samples have post length less than or equal to 0. This is nearly 25% of the total. These may be empty posts or data collection errors. They need further cleaning.

## Parent Page Comments

```sql
SELECT 
AVG(column278) AS avg_min_parent_comments,
AVG(column279) AS avg_max_parent_comments,
AVG(column280) AS avg_avg_parent_comments
FROM blogdata_train
```

<img width="600" height="245" alt="屏幕截图 2026-06-27 222855" src="https://github.com/user-attachments/assets/ff474b6b-7522-48b9-8181-35186f0b683f" />

The parent page comment counts are very low. The average minimum is close to 0. The average maximum is 1.24. The average mean is only 0.77. Most blog posts got very few comments from parent pages.
