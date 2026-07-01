from django.urls import path

from . import views

urlpatterns = [
    path("", views.home, name="home"),

    path("login/", views.login_view, name="login"),
    path("logout/", views.logout_view, name="logout"),

    path("dashboard/", views.dashboard, name="dashboard"),

    path("prediction/", views.prediction_view, name="prediction"),

    path("history/", views.history_view, name="history"),
    path("history/export/", views.history_export_csv, name="history_export"),

    path("reports/", views.reports_view, name="reports"),
]
