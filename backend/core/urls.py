from django.urls import path

from .views import (
    AvailableTeacherView,
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
    
    path(
        "tasks/<int:task_id>/available/",
        AvailableTeacherView.as_view(),
        name="available-teachers",
    ),

]