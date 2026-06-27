# Blog Comment Prediction Dataset - Basic Statistics Report

## Dataset Overview

The dataset has 52,397 samples. The target variable and comment features have no missing values. The data is complete.

## Target Variable Distribution

The average of the target variable is 6.76. The minimum is 0 and the maximum is 1424. There are 33,559 samples with zero comments, which is 64.05% of the total. This means more than 60% of blog posts got no comments in the next 24 hours. The distribution is very skewed. A few popular posts got many comments. This is a zero-inflated problem.

## Outlier Detection

No negative values were found in comment and link features. The data is logically consistent. However, 643 samples have more than 500 total comments. These are extreme values, about 1.23% of the data. Also, 12,750 samples have post length less than or equal to 0. This is nearly 25% of the total. These may be empty posts or data collection errors. They need further cleaning.

## Parent Page Comments

The parent page comment counts are very low. The average minimum is close to 0. The average maximum is 1.24. The average mean is only 0.77. Most blog posts got very few comments from parent pages.
