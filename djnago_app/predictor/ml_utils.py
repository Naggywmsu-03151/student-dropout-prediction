"""
Machine learning inference pipeline for the Student Dropout Prediction System.

This mirrors — step for step — the pipeline built across the three project
notebooks:

    01_Data_Cleaning.ipynb        -> raw dataset, no feature changes
    02_Feature_Engineering.ipynb  -> engineered features + StandardScaler
    03_Model_Training.ipynb       -> Logistic Regression trained on the
                                      15 most important scaled features

Feature engineering (from 02_Feature_Engineering.ipynb, cells 5-8):

    Academic_Performance = (GPA + Semester_GPA + CGPA) / 3
    Study_Efficiency     = Study_Hours_per_Day * Attendance_Rate
    Academic_Risk        = Stress_Index + Assignment_Delay_Days
    Accessibility_Score  = Internet_Access - Travel_Time_Minutes

The fitted `scaler.pkl` expects exactly 21 raw+engineered columns (in a
fixed order, recovered at runtime from `scaler.feature_names_in_`).  The
fitted `best_model.pkl` (Logistic Regression, ~81.4% accuracy, ROC AUC
~0.818 per best_model_info.csv) was trained on a 15-column subset of those
scaled features, selected by Random Forest feature importance in Notebook 2,
Phase 5. That subset is likewise recovered at runtime from
`model.feature_names_in_`, so this code never hard-codes a column order that
could drift out of sync with the actual trained artifacts.
"""

import threading

import joblib
import numpy as np
import pandas as pd
from django.conf import settings

_lock = threading.Lock()
_model = None
_scaler = None


def _load_artifacts():
    global _model, _scaler
    if _model is None or _scaler is None:
        with _lock:
            if _model is None:
                _model = joblib.load(settings.ML_MODEL_PATH)
            if _scaler is None:
                _scaler = joblib.load(settings.ML_SCALER_PATH)
    return _model, _scaler


def engineer_features(raw: dict) -> dict:
    """Add the four derived columns used during training."""
    engineered = dict(raw)
    engineered["Academic_Performance"] = (
        raw["GPA"] + raw["Semester_GPA"] + raw["CGPA"]
    ) / 3
    engineered["Study_Efficiency"] = (
        raw["Study_Hours_per_Day"] * raw["Attendance_Rate"]
    )
    engineered["Academic_Risk"] = (
        raw["Stress_Index"] + raw["Assignment_Delay_Days"]
    )
    engineered["Accessibility_Score"] = (
        raw["Internet_Access"] - raw["Travel_Time_Minutes"]
    )
    return engineered


def predict_dropout(raw: dict) -> dict:
    """
    raw: dict with the 17 raw feature keys (see FEATURE_FORM_ORDER below),
         using the same numeric encoding as the training CSVs.

    Returns a dict: {
        "probability": float 0-1 (probability of Dropout == 1),
        "predicted_class": 0 or 1,
        "risk_level": "LOW" | "MEDIUM" | "HIGH",
    }
    """
    model, scaler = _load_artifacts()

    engineered = engineer_features(raw)

    # Build the row in exactly the order the scaler was fit on.
    scaler_columns = list(scaler.feature_names_in_)
    row_df = pd.DataFrame([{col: engineered[col] for col in scaler_columns}])

    scaled = scaler.transform(row_df)
    scaled_df = pd.DataFrame(scaled, columns=scaler_columns)

    # Select only the columns the model was actually trained on.
    model_columns = list(model.feature_names_in_)
    model_input = scaled_df[model_columns]

    probability = float(model.predict_proba(model_input)[0][1])
    predicted_class = int(model.predict(model_input)[0])

    if probability >= 0.66:
        risk_level = "HIGH"
    elif probability >= 0.33:
        risk_level = "MEDIUM"
    else:
        risk_level = "LOW"

    return {
        "probability": probability,
        "predicted_class": predicted_class,
        "risk_level": risk_level,
    }


# Raw feature keys expected by engineer_features()/predict_dropout(),
# in a sensible order for building forms.
FEATURE_FORM_ORDER = [
    "Age",
    "Gender",
    "Family_Income",
    "Internet_Access",
    "Study_Hours_per_Day",
    "Attendance_Rate",
    "Assignment_Delay_Days",
    "Travel_Time_Minutes",
    "Part_Time_Job",
    "Scholarship",
    "Stress_Index",
    "GPA",
    "Semester_GPA",
    "CGPA",
    "Semester",
    "Department",
    "Parental_Education",
]
