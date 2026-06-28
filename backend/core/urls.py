from django.urls import path

from .views import (
    GenerateTaskView,
    PendingTaskView,
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

    path(
        "tasks/pending/",
        PendingTaskView.as_view(),
        name="pending-tasks",
    ),

]