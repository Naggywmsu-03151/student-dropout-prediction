import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='PredictionRecord',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('student_name', models.CharField(max_length=150)),
                ('student_number', models.CharField(blank=True, max_length=50)),
                ('age', models.FloatField()),
                ('gender', models.IntegerField(choices=[(0, 'Female'), (1, 'Male')])),
                ('family_income', models.FloatField(help_text='Monthly family income in PHP')),
                ('internet_access', models.IntegerField(choices=[(0, 'No'), (1, 'Yes')])),
                ('study_hours_per_day', models.FloatField()),
                ('attendance_rate', models.FloatField(help_text='0.0 - 1.0')),
                ('assignment_delay_days', models.FloatField()),
                ('travel_time_minutes', models.FloatField()),
                ('part_time_job', models.IntegerField(choices=[(0, 'No'), (1, 'Yes')])),
                ('scholarship', models.IntegerField(choices=[(0, 'No'), (1, 'Yes')])),
                ('stress_index', models.FloatField(help_text='0.0 - 10.0')),
                ('gpa', models.FloatField()),
                ('semester_gpa', models.FloatField()),
                ('cgpa', models.FloatField()),
                ('semester', models.IntegerField(choices=[(0, '1st Year'), (1, '2nd Year'), (2, '3rd Year'), (3, '4th Year')])),
                ('department', models.IntegerField(choices=[(0, 'College of Computing Studies'), (1, 'College of Engineering'), (2, 'College of Education'), (3, 'College of Arts and Sciences'), (4, 'College of Business Administration')])),
                ('parental_education', models.IntegerField(choices=[(0, 'Elementary'), (1, 'High School'), (2, 'College'), (3, 'Postgraduate')])),
                ('dropout_probability', models.FloatField()),
                ('predicted_class', models.IntegerField(help_text='0 = will stay, 1 = predicted dropout')),
                ('risk_level', models.CharField(choices=[('LOW', 'Low Risk'), ('MEDIUM', 'Medium Risk'), ('HIGH', 'High Risk')], max_length=10)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('created_by', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='predictions', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['-created_at'],
            },
        ),
    ]
