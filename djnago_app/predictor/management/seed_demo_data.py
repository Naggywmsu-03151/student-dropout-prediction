import random

from django.contrib.auth.models import User
from django.core.management.base import BaseCommand

from predictor.ml_utils import predict_dropout
from predictor.models import PredictionRecord

FIRST_NAMES = [
    "Ahmad", "Nur", "Jamal", "Farida", "Kamal", "Aina", "Halima", "Sultan",
    "Yusuf", "Amina", "Rashid", "Layla", "Hakim", "Zara", "Bakr", "Salma",
    "Tariq", "Noor", "Malik", "Iman",
]
LAST_NAMES = [
    "Abubakar", "Hassan", "Ismail", "Karim", "Latif", "Musa", "Osman",
    "Rahim", "Salih", "Umar", "Yasin", "Zulkifli",
]


class Command(BaseCommand):
    help = "Seed the database with demo prediction records so dashboard/history/reports aren't empty."

    def add_arguments(self, parser):
        parser.add_argument("--count", type=int, default=40, help="Number of demo records to create")

    def handle(self, *args, **options):
        count = options["count"]
        user = User.objects.filter(is_superuser=True).first()
        if user is None:
            self.stdout.write(self.style.WARNING(
                "No superuser found — create one first with `python manage.py createsuperuser`."
            ))
            return

        random.seed(42)
        created = 0

        for _ in range(count):
            # randomly bias toward either a "healthy" or "at-risk" profile
            at_risk = random.random() < 0.35

            if at_risk:
                gpa = round(random.uniform(1.0, 2.3), 2)
                attendance = round(random.uniform(0.4, 0.7), 2)
                stress = round(random.uniform(6, 10), 1)
                delay = random.randint(4, 15)
                study_hours = round(random.uniform(0.5, 2), 1)
                income = random.randint(10000, 22000)
            else:
                gpa = round(random.uniform(2.5, 4.0), 2)
                attendance = round(random.uniform(0.8, 1.0), 2)
                stress = round(random.uniform(1, 5), 1)
                delay = random.randint(0, 3)
                study_hours = round(random.uniform(2, 6), 1)
                income = random.randint(20000, 65000)

            raw = {
                "Age": random.randint(17, 27),
                "Gender": random.randint(0, 1),
                "Family_Income": income,
                "Internet_Access": random.randint(0, 1),
                "Study_Hours_per_Day": study_hours,
                "Attendance_Rate": attendance,
                "Assignment_Delay_Days": delay,
                "Travel_Time_Minutes": random.randint(5, 90),
                "Part_Time_Job": random.randint(0, 1),
                "Scholarship": random.randint(0, 1),
                "Stress_Index": stress,
                "GPA": gpa,
                "Semester_GPA": round(gpa + random.uniform(-0.2, 0.2), 2),
                "CGPA": round(gpa + random.uniform(-0.1, 0.1), 2),
                "Semester": random.randint(0, 3),
                "Department": random.randint(0, 4),
                "Parental_Education": random.randint(0, 3),
            }

            result = predict_dropout(raw)

            PredictionRecord.objects.create(
                student_name=f"{random.choice(FIRST_NAMES)} {random.choice(LAST_NAMES)}",
                student_number=f"2026-{random.randint(1000,9999)}",
                age=raw["Age"],
                gender=raw["Gender"],
                family_income=raw["Family_Income"],
                internet_access=raw["Internet_Access"],
                study_hours_per_day=raw["Study_Hours_per_Day"],
                attendance_rate=raw["Attendance_Rate"],
                assignment_delay_days=raw["Assignment_Delay_Days"],
                travel_time_minutes=raw["Travel_Time_Minutes"],
                part_time_job=raw["Part_Time_Job"],
                scholarship=raw["Scholarship"],
                stress_index=raw["Stress_Index"],
                gpa=raw["GPA"],
                semester_gpa=raw["Semester_GPA"],
                cgpa=raw["CGPA"],
                semester=raw["Semester"],
                department=raw["Department"],
                parental_education=raw["Parental_Education"],
                dropout_probability=result["probability"],
                predicted_class=result["predicted_class"],
                risk_level=result["risk_level"],
                created_by=user,
            )
            created += 1

        self.stdout.write(self.style.SUCCESS(f"Created {created} demo prediction records."))
