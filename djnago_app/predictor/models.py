from django.conf import settings
from django.db import models


class PredictionRecord(models.Model):
    """
    One row = one dropout-risk prediction made through the Prediction page.

    Raw (pre-engineering) fields mirror exactly the columns the trained
    scaler/model pipeline expects, as documented in predictor/ml_utils.py.
    Encoded integer choices (Gender, Internet_Access, etc.) match the
    encoding used when the training CSVs (student_dropout_v1/v2/v3.csv)
    were built.
    """

    GENDER_CHOICES = [
        (0, "Female"),
        (1, "Male"),
    ]

    YES_NO_CHOICES = [
        (0, "No"),
        (1, "Yes"),
    ]

    SEMESTER_CHOICES = [
        (0, "1st Year"),
        (1, "2nd Year"),
        (2, "3rd Year"),
        (3, "4th Year"),
    ]

    DEPARTMENT_CHOICES = [
        (0, "College of Computing Studies"),
        (1, "College of Engineering"),
        (2, "College of Education"),
        (3, "College of Arts and Sciences"),
        (4, "College of Business Administration"),
    ]

    PARENTAL_EDUCATION_CHOICES = [
        (0, "Elementary"),
        (1, "High School"),
        (2, "College"),
        (3, "Postgraduate"),
    ]

    RISK_LOW = "LOW"
    RISK_MEDIUM = "MEDIUM"
    RISK_HIGH = "HIGH"
    RISK_LEVEL_CHOICES = [
        (RISK_LOW, "Low Risk"),
        (RISK_MEDIUM, "Medium Risk"),
        (RISK_HIGH, "High Risk"),
    ]

    # --- Identifying info (not used by the model, for record-keeping only)
    student_name = models.CharField(max_length=150)
    student_number = models.CharField(max_length=50, blank=True)

    # --- Raw input features (fed into the feature-engineering pipeline)
    age = models.FloatField()
    gender = models.IntegerField(choices=GENDER_CHOICES)
    family_income = models.FloatField(help_text="Monthly family income in PHP")
    internet_access = models.IntegerField(choices=YES_NO_CHOICES)
    study_hours_per_day = models.FloatField()
    attendance_rate = models.FloatField(help_text="0.0 - 1.0")
    assignment_delay_days = models.FloatField()
    travel_time_minutes = models.FloatField()
    part_time_job = models.IntegerField(choices=YES_NO_CHOICES)
    scholarship = models.IntegerField(choices=YES_NO_CHOICES)
    stress_index = models.FloatField(help_text="0.0 - 10.0")
    gpa = models.FloatField()
    semester_gpa = models.FloatField()
    cgpa = models.FloatField()
    semester = models.IntegerField(choices=SEMESTER_CHOICES)
    department = models.IntegerField(choices=DEPARTMENT_CHOICES)
    parental_education = models.IntegerField(choices=PARENTAL_EDUCATION_CHOICES)

    # --- Model output
    dropout_probability = models.FloatField()
    predicted_class = models.IntegerField(help_text="0 = will stay, 1 = predicted dropout")
    risk_level = models.CharField(max_length=10, choices=RISK_LEVEL_CHOICES)

    # --- Metadata
    created_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        related_name="predictions",
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.student_name} — {self.get_risk_level_display()} ({self.dropout_probability:.1%})"

    @property
    def dropout_probability_percent(self):
        """dropout_probability is stored as a 0-1 fraction; this returns 0-100 for display."""
        return self.dropout_probability * 100
