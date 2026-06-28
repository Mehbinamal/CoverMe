from django.urls import path

from .views import (
    GenerateTaskView,
    TeacherListView,
    LeaveView,
)

urlpatterns = [

    path(
        "teachers/",
        TeacherListView.as_view()
    ),

    path(
        "leaves/",
        LeaveView.as_view()
    ),

    path(
        "tasks/generate/",
        GenerateTaskView.as_view()
),

]