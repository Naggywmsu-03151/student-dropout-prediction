from django import forms
from django.contrib.auth.forms import AuthenticationForm

from .models import PredictionRecord


class StyledAuthenticationForm(AuthenticationForm):
    """Adds Bootstrap classes to Django's built-in login form."""

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["username"].widget.attrs.update({
            "class": "form-control",
            "placeholder": "Enter your username",
            "autofocus": True,
        })
        self.fields["password"].widget.attrs.update({
            "class": "form-control",
            "placeholder": "Enter your password",
        })


class PredictionForm(forms.ModelForm):
    """
    Form used on the Prediction page. Field order matches
    predictor.ml_utils.FEATURE_FORM_ORDER (plus the two identity fields).
    """

    class Meta:
        model = PredictionRecord
        fields = [
            "student_name",
            "student_number",
            "age",
            "gender",
            "family_income",
            "internet_access",
            "study_hours_per_day",
            "attendance_rate",
            "assignment_delay_days",
            "travel_time_minutes",
            "part_time_job",
            "scholarship",
            "stress_index",
            "gpa",
            "semester_gpa",
            "cgpa",
            "semester",
            "department",
            "parental_education",
        ]
        widgets = {
            "student_name": forms.TextInput(attrs={"class": "form-control", "placeholder": "e.g. Juan Dela Cruz"}),
            "student_number": forms.TextInput(attrs={"class": "form-control", "placeholder": "e.g. 2023-00123"}),
            "age": forms.NumberInput(attrs={"class": "form-control", "min": 15, "max": 60, "step": 1}),
            "gender": forms.Select(attrs={"class": "form-select"}),
            "family_income": forms.NumberInput(attrs={"class": "form-control", "min": 0, "step": 500}),
            "internet_access": forms.Select(attrs={"class": "form-select"}),
            "study_hours_per_day": forms.NumberInput(attrs={"class": "form-control", "min": 0, "max": 24, "step": 0.5}),
            "attendance_rate": forms.NumberInput(attrs={"class": "form-control", "min": 0, "max": 1, "step": 0.01}),
            "assignment_delay_days": forms.NumberInput(attrs={"class": "form-control", "min": 0, "step": 1}),
            "travel_time_minutes": forms.NumberInput(attrs={"class": "form-control", "min": 0, "step": 1}),
            "part_time_job": forms.Select(attrs={"class": "form-select"}),
            "scholarship": forms.Select(attrs={"class": "form-select"}),
            "stress_index": forms.NumberInput(attrs={"class": "form-control", "min": 0, "max": 10, "step": 0.1}),
            "gpa": forms.NumberInput(attrs={"class": "form-control", "min": 0, "max": 4, "step": 0.01}),
            "semester_gpa": forms.NumberInput(attrs={"class": "form-control", "min": 0, "max": 4, "step": 0.01}),
            "cgpa": forms.NumberInput(attrs={"class": "form-control", "min": 0, "max": 4, "step": 0.01}),
            "semester": forms.Select(attrs={"class": "form-select"}),
            "department": forms.Select(attrs={"class": "form-select"}),
            "parental_education": forms.Select(attrs={"class": "form-select"}),
        }
        labels = {
            "student_name": "Student Name",
            "student_number": "Student Number (optional)",
            "family_income": "Monthly Family Income (PHP)",
            "internet_access": "Has Internet Access",
            "study_hours_per_day": "Study Hours per Day",
            "attendance_rate": "Attendance Rate (0.00 - 1.00)",
            "assignment_delay_days": "Avg. Assignment Delay (days)",
            "travel_time_minutes": "Travel Time to Campus (minutes)",
            "part_time_job": "Has a Part-time Job",
            "scholarship": "Has a Scholarship",
            "stress_index": "Stress Index (0-10)",
            "gpa": "Current GPA",
            "semester_gpa": "Semester GPA",
            "cgpa": "Cumulative GPA (CGPA)",
        }

    def to_raw_features(self):
        """Map the cleaned form data to the raw feature dict ml_utils expects."""
        d = self.cleaned_data
        return {
            "Age": d["age"],
            "Gender": d["gender"],
            "Family_Income": d["family_income"],
            "Internet_Access": d["internet_access"],
            "Study_Hours_per_Day": d["study_hours_per_day"],
            "Attendance_Rate": d["attendance_rate"],
            "Assignment_Delay_Days": d["assignment_delay_days"],
            "Travel_Time_Minutes": d["travel_time_minutes"],
            "Part_Time_Job": d["part_time_job"],
            "Scholarship": d["scholarship"],
            "Stress_Index": d["stress_index"],
            "GPA": d["gpa"],
            "Semester_GPA": d["semester_gpa"],
            "CGPA": d["cgpa"],
            "Semester": d["semester"],
            "Department": d["department"],
            "Parental_Education": d["parental_education"],
        }


class HistorySearchForm(forms.Form):
    q = forms.CharField(required=False, widget=forms.TextInput(attrs={
        "class": "form-control", "placeholder": "Search by name or student number..."
    }))
    risk_level = forms.ChoiceField(
        required=False,
        choices=[("", "All Risk Levels")] + PredictionRecord.RISK_LEVEL_CHOICES,
        widget=forms.Select(attrs={"class": "form-select"}),
    )
    department = forms.ChoiceField(
        required=False,
        choices=[("", "All Departments")] + PredictionRecord.DEPARTMENT_CHOICES,
        widget=forms.Select(attrs={"class": "form-select"}),
    )
