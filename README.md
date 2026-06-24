## Project Overview

This project is the final report for STQD6324 Data Management. It shows big data analysis skills through a complete data management process (data cleaning, modeling, evaluation, and storage). The project is built on Hadoop Sandbox 2.6.5, uses PySpark for data processing and modeling, and stores some results in MongoDB.

---

## Dataset: BlogFeedback

### Why This Dataset?
I want to work in digital marketing and social media analytics. In this industry, predicting blog post popularity (number of comments) is very valuable. It helps content creators plan their posts and helps companies measure content marketing results.

Source: https://archive.ics.uci.edu/dataset/304/blogfeedback
<img width="698" height="351" alt="屏幕截图 2026-06-18 091944" src="https://github.com/user-attachments/assets/807dcc17-6ccf-4936-aeb5-4934c9daef12" />

I chose the BlogFeedback dataset from UC Irvine Machine Learning Repository for these reasons:

1. Predicting comment count is a classic problem in social media analytics
2. 281 raw columns with lots of redundant and noisy data, good for practicing data cleaning
3. About 50k rows, suitable for Hadoop Sandbox and shows the value of big data tools
4. The target (comment count) has many zeros, good for trying different modeling approaches

---

## Environment and Tools

| Component | Version / Description |
|-----------|----------------------|
| OS | Virtual Box VM |
| Hadoop | Hadoop Sandbox 2.6.5 |
| Big Data Processing | pyspark 2.3.0|
| Machine Learning | PySpark ML + scikit-learn |
| Storage | HDFS + MongoDB |
| Development Tool | Jupyter Notebook |
|Remote Access | Tabby SSH Terminal |

---

## Project Structure

---
BlogFeedback_Project/
│
├── notebooks/
│   └── 1_data_clean.ipynb     # Data cleaning notebook
│   └── 2_data_process.ipynb   # Modeling notebook
├── data/
│   ├── raw/                   # Raw CSV files (61 files)
│   └── clean/                 # Cleaned data files
├── README.md                  # Project documentation
└── requirements.txt           # Python dependencies
```



## Analysis Workflow

### Step 1: Data Upload & Cleaning

**Data Upload**

Use Tabby SSH to connect to Hadoop Sandbox on port 2222, then upload files via SFTP.
<img width="599" height="302" alt="屏幕截图 2026-06-18 093255" src="https://github.com/user-attachments/assets/7d6b0031-9596-4c44-bdbc-981f3992e19d" />
<img width="663" height="453" alt="屏幕截图 2026-06-18 093150" src="https://github.com/user-attachments/assets/fd99154c-4cb2-46cd-b567-89df3a06e846" />

After uploading, run these commands in the terminal to move files to HDFS:

```
hdfs dfs -mkdir -p /user/maria_dev/blog_project/raw
hdfs dfs -mkdir -p /user/maria_dev/blog_project/clean
cd blog_data
hdfs dfs -put blogData_train.csv /user/maria_dev/blog_project/raw/
hdfs dfs -put blogData_test-*.csv /user/maria_dev/blog_project/raw/
```

<img width="551" height="131" alt="屏幕截图 2026-06-18 093654" src="https://github.com/user-attachments/assets/bda63266-8423-48cb-826e-d624f64e3977" />
<img width="770" height="659" alt="屏幕截图 2026-06-18 093727" src="https://github.com/user-attachments/assets/1fcc0b3c-e122-443c-bfff-c6b75f04bf2e" />


**Data Cleaning**

- Read raw data of train set (281 columns, 52397 rows)
- Rename columns (target + feature_0 ~ feature_279)
- Remove constant columns, 4 columns removed
- Check missing values (none found)
- Remove exact duplicate rows, 3194 rows removed
- Convert target column to integer type
- Clean and save 60 test files

### Step 2: Feature Engineering & Data Split

- Combine 276 feature columns into one vector column
- Split data into training and test sets at 8:2 ratio

### Step 3: Modeling & Evaluation

| Model | Test R² | Test MAE | Note |
|-------|---------|----------|------|
| Random Forest (17 trees) | **0.617** | 5.04 | Best model |
| PCA + Linear Regression (k=50) | 0.442 | 0.564 | Lower performance after reduction |
| Two-Stage Model (classification + regression) | 0.5088 | 4.08 | Handles zero values |
| MLP Neural Network (sklearn) | 0.5091 | 6.30 | For comparison only |

Random Forest with 17 trees gives the best result (R² = 0.617). On the full test set, the two-stage model is more stable (R² = 0.407).

### Step 4: Store Results

- Save best results (R², MAE, data statistics) to MongoDB





## Key Technical Highlights

- Use **PySpark** to process large CSV files
- Use **VectorAssembler** to combine high-dimensional features
- Use **PCA** for dimension reduction experiments
- Build a **two-stage model** (classification + regression)
- Convert PySpark DataFrame to NumPy arrays and use **scikit-learn** for MLP modeling
- Store summary results in **MongoDB**

---

## Conclusion & Recommendations

### Conclusion
Through the complete data cleaning process on the BlogFeedback dataset, we found:

1. There are 4 constant columns and 3194 duplicate rows in the raw data. Removing them improves model efficiency.
2. Random Forest performs best for predicting blog comment count (R² = 0.617).
3. Since the target has many zero values, the two-stage model provides a good alternative.
4. PCA reduces features significantly but also lowers prediction accuracy (R² drops from 0.617 to 0.442).

### Recommendations

- This model can be used to predict post popularity in real-time for better content recommendations.
- In the future, we can add more features (like user profiles, post time, social media data) to improve prediction.

---

## How to Run
1. Start Hadoop Sandbox 2.6.5
2. Upload data files to HDFS: `/user/maria_dev/blog_project/raw/`
3. Start Jupyter Notebook
4. Run `1_data_clean.ipynb` first, then `2_data_process.ipynb`


## References
- UCI Machine Learning Repository – BlogFeedback Dataset
- PySpark Documentation
- scikit-learn Documentation
- MongoDB Documentation
