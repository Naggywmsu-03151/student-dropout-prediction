import csv
import json

from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import Avg, Count, Q
from django.http import HttpResponse
from django.shortcuts import redirect, render

from .forms import HistorySearchForm, PredictionForm, StyledAuthenticationForm
from .ml_utils import predict_dropout
from .models import PredictionRecord


# ==========================================================
# Authentication
# ==========================================================

def home(request):
    return redirect("dashboard" if request.user.is_authenticated else "login")


def login_view(request):
    error = ""

    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")

        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            return redirect("dashboard")
        else:
            error = "Invalid username or password."

    form = StyledAuthenticationForm()
    return render(request, "login.html", {"error": error, "form": form})


def logout_view(request):
    logout(request)
    return redirect("login")


# ==========================================================
# Dashboard
# ==========================================================

@login_required(login_url="login")
def dashboard(request):
    total_predictions = PredictionRecord.objects.count()
    high_risk = PredictionRecord.objects.filter(risk_level=PredictionRecord.RISK_HIGH).count()
    medium_risk = PredictionRecord.objects.filter(risk_level=PredictionRecord.RISK_MEDIUM).count()
    low_risk = PredictionRecord.objects.filter(risk_level=PredictionRecord.RISK_LOW).count()

    recent = PredictionRecord.objects.select_related("created_by")[:6]

    risk_chart_data = {
        "labels": ["Low Risk", "Medium Risk", "High Risk"],
        "values": [low_risk, medium_risk, high_risk],
    }

    context = {
        "user": request.user,
        "total_predictions": total_predictions,
        "high_risk": high_risk,
        "medium_risk": medium_risk,
        "low_risk": low_risk,
        "model_accuracy": 81.4,  # from best_model_info.csv (Logistic Regression)
        "recent": recent,
        "risk_chart_data": json.dumps(risk_chart_data),
    }
    return render(request, "dashboard.html", context)


# ==========================================================
# Prediction
# ==========================================================

@login_required(login_url="login")
def prediction_view(request):
    result = None

    if request.method == "POST":
        form = PredictionForm(request.POST)
        if form.is_valid():
            raw_features = form.to_raw_features()
            result = predict_dropout(raw_features)

            record = form.save(commit=False)
            record.dropout_probability = result["probability"]
            record.predicted_class = result["predicted_class"]
            record.risk_level = result["risk_level"]
            record.created_by = request.user
            record.save()

            result["record"] = record
    else:
        form = PredictionForm()

    return render(request, "prediction_form.html", {"form": form, "result": result})


# ==========================================================
# History
# ==========================================================

@login_required(login_url="login")
def history_view(request):
    search_form = HistorySearchForm(request.GET or None)
    records = PredictionRecord.objects.select_related("created_by")

    if search_form.is_valid():
        q = search_form.cleaned_data.get("q")
        risk_level = search_form.cleaned_data.get("risk_level")
        department = search_form.cleaned_data.get("department")

        if q:
            records = records.filter(
                Q(student_name__icontains=q) | Q(student_number__icontains=q)
            )
        if risk_level:
            records = records.filter(risk_level=risk_level)
        if department:
            records = records.filter(department=department)

    paginator = Paginator(records, 15)
    page_number = request.GET.get("page")
    page_obj = paginator.get_page(page_number)

    return render(request, "history.html", {
        "search_form": search_form,
        "page_obj": page_obj,
        "total_count": records.count(),
    })


@login_required(login_url="login")
def history_export_csv(request):
    search_form = HistorySearchForm(request.GET or None)
    records = PredictionRecord.objects.select_related("created_by")

    if search_form.is_valid():
        q = search_form.cleaned_data.get("q")
        risk_level = search_form.cleaned_data.get("risk_level")
        department = search_form.cleaned_data.get("department")

        if q:
            records = records.filter(
                Q(student_name__icontains=q) | Q(student_number__icontains=q)
            )
        if risk_level:
            records = records.filter(risk_level=risk_level)
        if department:
            records = records.filter(department=department)

    response = HttpResponse(content_type="text/csv")
    response["Content-Disposition"] = 'attachment; filename="prediction_history.csv"'

    writer = csv.writer(response)
    writer.writerow([
        "Student Name", "Student Number", "Department", "Semester",
        "GPA", "CGPA", "Attendance Rate", "Dropout Probability",
        "Risk Level", "Predicted By", "Date"
    ])
    for r in records:
        writer.writerow([
            r.student_name,
            r.student_number,
            r.get_department_display(),
            r.get_semester_display(),
            r.gpa,
            r.cgpa,
            r.attendance_rate,
            f"{r.dropout_probability:.2%}",
            r.get_risk_level_display(),
            r.created_by.username if r.created_by else "",
            r.created_at.strftime("%Y-%m-%d %H:%M"),
        ])

    return response


# ==========================================================
# Reports
# ==========================================================

@login_required(login_url="login")
def reports_view(request):
    total = PredictionRecord.objects.count()

    by_department = (
        PredictionRecord.objects.values("department")
        .annotate(count=Count("id"), avg_prob=Avg("dropout_probability"))
        .order_by("department")
    )
    dept_labels_map = dict(PredictionRecord.DEPARTMENT_CHOICES)
    department_chart = {
        "labels": [dept_labels_map.get(row["department"], "Unknown") for row in by_department],
        "values": [round((row["avg_prob"] or 0) * 100, 1) for row in by_department],
        "counts": [row["count"] for row in by_department],
    }

    by_risk = (
        PredictionRecord.objects.values("risk_level")
        .annotate(count=Count("id"))
        .order_by("risk_level")
    )
    risk_labels_map = dict(PredictionRecord.RISK_LEVEL_CHOICES)
    risk_counts = {row["risk_level"]: row["count"] for row in by_risk}
    risk_chart = {
        "labels": ["Low Risk", "Medium Risk", "High Risk"],
        "values": [
            risk_counts.get(PredictionRecord.RISK_LOW, 0),
            risk_counts.get(PredictionRecord.RISK_MEDIUM, 0),
            risk_counts.get(PredictionRecord.RISK_HIGH, 0),
        ],
    }

    by_semester = (
        PredictionRecord.objects.values("semester")
        .annotate(count=Count("id"), avg_prob=Avg("dropout_probability"))
        .order_by("semester")
    )
    sem_labels_map = dict(PredictionRecord.SEMESTER_CHOICES)
    semester_chart = {
        "labels": [sem_labels_map.get(row["semester"], "Unknown") for row in by_semester],
        "values": [round((row["avg_prob"] or 0) * 100, 1) for row in by_semester],
    }

    context = {
        "total": total,
        "model_metrics": {
            "accuracy": 81.4,
            "precision": 67.0,
            "recall": 41.4,
            "f1_score": 51.2,
            "roc_auc": 81.8,
        },
        "department_chart": json.dumps(department_chart),
        "risk_chart": json.dumps(risk_chart),
        "semester_chart": json.dumps(semester_chart),
    }
    return render(request, "reports.html", context)
