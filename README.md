# Student Dropout Prediction System
**MIT Final Project — Machine Learning + Django Web Application**

## Project Description

The Student Dropout Prediction System is a Machine Learning-based web application developed to identify students who are at risk of dropping out. The project uses student demographic, academic, and socioeconomic information to predict dropout status. Various machine learning algorithms are evaluated to determine the most accurate predictive model, which is then deployed using Django for real-time predictions.

---

## Project Objectives

The project aims to:

- Predict whether a student is likely to drop out.
- Compare the performance of multiple Machine Learning algorithms.
- Improve prediction accuracy through data cleaning and feature engineering.
- Deploy the best-performing model into a Django web application.
- Provide prediction history for future reference.

---

## Dataset Information

Dataset Name:

Student Dropout Dataset

Dataset Source:

https://www.kaggle.com/datasets/meharshanali/student-dropout-prediction-dataset

Dataset provided by the course instructor.

Number of Records:

10,000

Number of Features:

19

Target Variable:

Dropout



## Dataset Features

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


## Feature Engineering

The project includes:

- Removing irrelevant columns
- Removing Student_ID
- Creating new academic performance features
- Feature scaling
- Feature selection
- Dataset versioning

---

## Machine Learning Algorithms

The following algorithms are evaluated:

1. Logistic Regression
2. Decision Tree
3. Random Forest
4. Support Vector Machine (SVM)
5. XGBoost

---

## Performance Evaluation Metrics

The models are evaluated using:

- Accuracy
- Precision
- Recall
- F1 Score
- ROC-AUC Score
- Confusion Matrix

---

## 1. What's inside

student-dropout-prediction-system/
├── manage.py
├── requirements.txt
├── README.md
├── .gitignore
├── config/                    # Django project settings/urls
├── predictor/                 # Main Django app
│   ├── models.py              # PredictionRecord model
│   ├── forms.py                # Login form + Prediction form + History search form
│   ├── views.py                # Dashboard, Prediction, History, Reports, Auth
│   ├── ml_utils.py             # Feature engineering + inference pipeline
│   ├── admin.py
│   ├── tests.py                # 6 automated tests (ML pipeline + views)
│   ├── management/commands/
│   │   └── seed_demo_data.py   # Optional: generates demo prediction records
│   ├── templates/
│   │   ├── base.html
│   │   ├── dashboard_base.html # Sidebar + navbar + footer layout
│   │   ├── login.html
│   │   ├── dashboard.html
│   │   ├── prediction_form.html
│   │   ├── history.html
│   │   ├── reports.html
│   │   └── partials/ (sidebar.html, navbar.html, footer.html)
│   └── static/css/style.css
├── ml_models/
│   ├── best_model.pkl          # Trained Logistic Regression model
│   └── scaler.pkl              # Fitted StandardScaler
└── db.sqlite3                  # Pre-seeded with 1 admin account + demo records


## 2. Where the ML model came from

This project's three notebooks are the ground truth for the pipeline
re-implemented in `predictor/ml_utils.py`:

1. **01_Data_Cleaning.ipynb** — loads and inspects the raw dataset.
2. **02_Feature_Engineering.ipynb** — drops `Student_ID`, engineers 4 new
   columns, fits a `StandardScaler` on 21 columns, then selects the 15 most
   important columns (via Random Forest feature importance) for the final
   model.
3. **03_Model_Training.ipynb** — trains/compares 5 algorithms across 3
   dataset versions; Logistic Regression on the engineered+selected feature
   set won with **81.4% accuracy**, **0.818 ROC AUC**.

Engineered features (computed live in `ml_utils.py` from your form inputs):

| Feature | Formula |
|---|---|
| `Academic_Performance` | `(GPA + Semester_GPA + CGPA) / 3` |
| `Study_Efficiency` | `Study_Hours_per_Day * Attendance_Rate` |
| `Academic_Risk` | `Stress_Index + Assignment_Delay_Days` |
| `Accessibility_Score` | `Internet_Access - Travel_Time_Minutes` |

`ml_utils.py` never hard-codes column order — it reads
`scaler.feature_names_in_` and `model.feature_names_in_` directly from the
pickled objects at runtime, so the pipeline can never silently drift out of
sync with the artifacts you trained.

> **Encoding assumptions.** The uploaded training CSVs already had
> categorical columns label-encoded as integers (e.g. `Gender`, `Department`,
> `Parental_Education`), but the original text-to-integer mapping wasn't
> included in your files. The dropdown labels in the Prediction form
> (`predictor/models.py` → `*_CHOICES`) are my best reasonable
> reconstruction (e.g. `Department: 0=CCS, 1=Engineering, 2=Education,
> 3=Arts & Sciences, 4=Business`). **Please double-check these against your
> own data dictionary / thesis manuscript** and edit the `CHOICES` tuples in
> `predictor/models.py` if the actual mapping differs — the numeric values
> fed to the model will still be correct either way, only the on-screen
> labels would need adjusting.

## 3. Setup 

```bash
# 1. Create and activate a virtual environment
python -m venv venv
venv\Scripts\activate        # Windows
source venv/bin/activate     # macOS/Linux

# 2. Install dependencies
pip install -r requirements.txt

# 3. Apply database migrations (db.sqlite3 is already included and seeded,
#    but this is here in case you start from a clean database)
python manage.py migrate

# 4. (Optional, only if db.sqlite3 is missing/empty) create an admin account
python manage.py createsuperuser

# 5. (Optional) generate demo prediction records for the dashboard/reports
python manage.py seed_demo_data --count 40

# 6. Run the server
python manage.py runserver
```

Visit **http://127.0.0.1:8000/login/**

### Default login (already seeded in db.sqlite3)
- **Username:** `admin`
- **Password:** `admin12345`

> Change this password (or delete `db.sqlite3` and re-create your own
> superuser) before showing this to your panel/adviser if you don't want the
> default credentials visible in your source.

## 4. Pages

| Page | URL | Description |
|---|---|---|
| Login | `/login/` | Django session authentication |
| Dashboard | `/dashboard/` | Stat cards + risk distribution doughnut chart + recent predictions |
| Prediction | `/prediction/` | Full student-profile form → live model inference → saved to History |
| History | `/history/` | Search by name/number, filter by risk level & department, paginated, **CSV export** |
| Reports | `/reports/` | Model metrics (accuracy/precision/recall/ROC AUC) + 3 Chart.js analytics charts |
| Admin | `/admin/` | Django built-in admin, registered `PredictionRecord` model |

## 5. Automated tests

```bash
python manage.py test predictor
```

6 tests covering: the ML pipeline returns valid probabilities, a clearly
at-risk profile scores higher than a clearly healthy profile, login-required
enforcement, and that every page (dashboard, prediction, history, reports)
renders successfully end to end.

## 6. Notes about this project:

- Model: **Logistic Regression**, trained on the 15-feature engineered +
  scaled dataset (Notebook 3, best-performing of 5 algorithms × 3 dataset
  versions tested).
- Metrics: Accuracy 81.4%, Precision 67.0%, Recall 41.4%, F1 51.2%, ROC AUC
  81.8% (from `best_model_info.csv`).
- Risk tiers used in the UI: **Low** (<33% probability), **Medium**
  (33–66%), **High** (≥66%) — thresholds set in `ml_utils.predict_dropout()`,
  adjustable to match your manuscript's methodology if it defines different
  cut-offs.
- The recall (41.4%) is comparatively low relative to accuracy — worth
  discussing in your paper's limitations section, since it means the model
  misses a meaningful share of actual dropouts. This is a legitimate,
  common trade-off to acknowledge rather than a bug in this codebase.

 
 ## Project Workflow

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

## Technologies Used

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

## Developer

Nagdir B. Muhadja

Master of Information Technology

Western Mindanao State University
