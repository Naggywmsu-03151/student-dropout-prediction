# Student Dropout Prediction System

## Project Description

The Student Dropout Prediction System is a Machine Learning-based web application developed to identify students who are at risk of dropping out. The project uses student demographic, academic, and socioeconomic information to predict dropout status. Various machine learning algorithms are evaluated to determine the most accurate predictive model, which is then deployed using Django for real-time predictions.

---

# Project Objectives

The project aims to:

- Predict whether a student is likely to drop out.
- Compare the performance of multiple Machine Learning algorithms.
- Improve prediction accuracy through data cleaning and feature engineering.
- Deploy the best-performing model into a Django web application.
- Provide prediction history for future reference.

---

# Dataset Information

Dataset Name:

Student Dropout Dataset

Dataset Source:

(Insert your dataset URL here if obtained online. If this dataset was provided by your instructor, write:)

Dataset provided by the course instructor.

Number of Records:

10,000

Number of Features:

19

Target Variable:

Dropout

---

# Dataset Features

| Feature | Description |
|----------|-------------|
| Student_ID | Unique student identifier |
| Age | Student age |
| Gender | Male or Female |
| Family_Income | Monthly family income |
| Internet_Access | Internet availability |
| Study_Hours_per_Day | Average study hours per day |
| Attendance_Rate | Attendance percentage |
| Assignment_Delay_Days | Number of delayed submission days |
| Travel_Time_Minutes | Travel time to school |
| Part_Time_Job | Whether the student has a part-time job |
| Scholarship | Scholarship status |
| Stress_Index | Student stress level |
| GPA | Current GPA |
| Semester_GPA | GPA for the current semester |
| CGPA | Cumulative GPA |
| Semester | Current semester/year level |
| Department | Student department |
| Parental_Education | Highest education level of parents |
| Dropout | Target Variable (0 = No, 1 = Yes) |

---

# Data Cleaning Techniques

The following preprocessing techniques are applied:

- Duplicate removal
- Missing value treatment
- Outlier detection and treatment
- Data consistency checking
- Label Encoding
- One-Hot Encoding
- Feature Scaling
- Normalization
- Standardization

---

# Feature Engineering

The project includes:

- Removing irrelevant columns
- Removing Student_ID
- Creating new academic performance features
- Feature scaling
- Feature selection
- Dataset versioning

---

# Machine Learning Algorithms

The following algorithms are evaluated:

1. Logistic Regression
2. Decision Tree
3. Random Forest
4. Support Vector Machine (SVM)
5. XGBoost

---

# Performance Evaluation Metrics

The models are evaluated using:

- Accuracy
- Precision
- Recall
- F1 Score
- ROC-AUC Score
- Confusion Matrix

---

# Project Workflow

Raw Dataset

↓

Data Cleaning

↓

Feature Engineering

↓

Dataset Version 1

↓

Dataset Version 2

↓

Dataset Version 3

↓

Model Training

↓

Model Evaluation

↓

Best Model Selection

↓

Model Deployment (Django)

↓

Prediction System

---

# Technologies Used

- Python
- Google Colab
- Pandas
- NumPy
- Scikit-Learn
- XGBoost
- Matplotlib
- Seaborn
- Django
- Joblib
- Git
- GitHub

---

# Developer

Nagdir B. Muhadja

Master of Information Technology

Western Mindanao State University

MIT Final Project
