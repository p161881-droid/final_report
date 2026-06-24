## Project Overview

This project is the final report for STQD6324 Data Management. It shows big data analysis skills through a complete data management process (data cleaning, modeling, evaluation, and storage). The project is built on Hadoop Sandbox 2.6.5, uses PySpark for data processing and modeling, and stores some results in MongoDB.

---

## Dataset: BlogFeedback

### Why This Dataset?

I want to work in digital marketing and social media analytics. In this industry, **predicting blog post popularity (number of comments)** is very valuable. It helps content creators plan their posts and helps companies measure content marketing results.

Source: https://archive.ics.uci.edu/dataset/304/blogfeedback

I chose the **BlogFeedback** dataset from UC Irvine Machine Learning Repository for these reasons:

1. Predicting comment count is a classic problem in social media analytics
2. 281 raw columns with lots of redundant and noisy data, good for practicing data cleaning
3. About 50k rows, suitable for Hadoop Sandbox and shows the value of big data tools
4. The target (comment count) has many zeros, good for trying different modeling approaches

---

## Environment

| Component | Version / Description |
|-----------|----------------------|
| OS | Virtual Box VM |
| Hadoop | Hadoop Sandbox 2.6.5 |
| Big Data Processing | PySpark |
| Machine Learning | PySpark ML + scikit-learn |
| Storage | HDFS + MongoDB |
| Development Tool | Jupyter Notebook |

---

## Project Structure
