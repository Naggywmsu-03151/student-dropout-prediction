from django.contrib.auth.models import User
from django.test import TestCase
from django.urls import reverse

from .ml_utils import predict_dropout
from .models import PredictionRecord


class MLPipelineTests(TestCase):
    def test_predict_dropout_returns_expected_shape(self):
        raw = {
            "Age": 20,
            "Gender": 1,
            "Family_Income": 25000,
            "Internet_Access": 1,
            "Study_Hours_per_Day": 3,
            "Attendance_Rate": 0.9,
            "Assignment_Delay_Days": 1,
            "Travel_Time_Minutes": 20,
            "Part_Time_Job": 0,
            "Scholarship": 1,
            "Stress_Index": 3,
            "GPA": 3.5,
            "Semester_GPA": 3.4,
            "CGPA": 3.5,
            "Semester": 1,
            "Department": 0,
            "Parental_Education": 2,
        }
        result = predict_dropout(raw)
        self.assertIn("probability", result)
        self.assertIn("risk_level", result)
        self.assertTrue(0.0 <= result["probability"] <= 1.0)
        self.assertIn(result["risk_level"], ["LOW", "MEDIUM", "HIGH"])

    def test_high_risk_profile_scores_higher_than_low_risk_profile(self):
        low_risk_raw = {
            "Age": 20, "Gender": 1, "Family_Income": 60000, "Internet_Access": 1,
            "Study_Hours_per_Day": 6, "Attendance_Rate": 0.98, "Assignment_Delay_Days": 0,
            "Travel_Time_Minutes": 10, "Part_Time_Job": 0, "Scholarship": 1,
            "Stress_Index": 1, "GPA": 3.9, "Semester_GPA": 3.9, "CGPA": 3.9,
            "Semester": 1, "Department": 0, "Parental_Education": 3,
        }
        high_risk_raw = {
            "Age": 24, "Gender": 0, "Family_Income": 12000, "Internet_Access": 0,
            "Study_Hours_per_Day": 0.5, "Attendance_Rate": 0.4, "Assignment_Delay_Days": 10,
            "Travel_Time_Minutes": 90, "Part_Time_Job": 1, "Scholarship": 0,
            "Stress_Index": 9, "GPA": 1.2, "Semester_GPA": 1.1, "CGPA": 1.3,
            "Semester": 3, "Department": 2, "Parental_Education": 0,
        }
        low = predict_dropout(low_risk_raw)
        high = predict_dropout(high_risk_raw)
        self.assertGreater(high["probability"], low["probability"])


class ViewAccessTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username="tester", password="testpass123")

    def test_dashboard_requires_login(self):
        response = self.client.get(reverse("dashboard"))
        self.assertEqual(response.status_code, 302)

    def test_login_then_dashboard_accessible(self):
        self.client.login(username="tester", password="testpass123")
        response = self.client.get(reverse("dashboard"))
        self.assertEqual(response.status_code, 200)

    def test_prediction_page_creates_record(self):
        self.client.login(username="tester", password="testpass123")
        response = self.client.post(reverse("prediction"), {
            "student_name": "Test Student",
            "student_number": "2026-00001",
            "age": 21,
            "gender": 1,
            "family_income": 25000,
            "internet_access": 1,
            "study_hours_per_day": 3,
            "attendance_rate": 0.85,
            "assignment_delay_days": 2,
            "travel_time_minutes": 30,
            "part_time_job": 0,
            "scholarship": 1,
            "stress_index": 4,
            "gpa": 3.2,
            "semester_gpa": 3.1,
            "cgpa": 3.2,
            "semester": 1,
            "department": 0,
            "parental_education": 2,
        })
        self.assertEqual(response.status_code, 200)
        self.assertEqual(PredictionRecord.objects.count(), 1)

    def test_history_and_reports_pages_load(self):
        self.client.login(username="tester", password="testpass123")
        self.assertEqual(self.client.get(reverse("history")).status_code, 200)
        self.assertEqual(self.client.get(reverse("reports")).status_code, 200)
