from django.urls import path

from .views import (
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

]