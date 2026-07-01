from django.contrib import admin

from .models import PredictionRecord


@admin.register(PredictionRecord)
class PredictionRecordAdmin(admin.ModelAdmin):
    list_display = (
        "student_name", "student_number", "department", "semester",
        "dropout_probability", "risk_level", "created_by", "created_at",
    )
    list_filter = ("risk_level", "department", "semester", "created_at")
    search_fields = ("student_name", "student_number")
    readonly_fields = ("dropout_probability", "predicted_class", "risk_level", "created_at")
