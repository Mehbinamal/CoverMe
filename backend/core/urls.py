from django.urls import path

from .views import FreeTeacherView

urlpatterns = [

    path(
        "free-teachers/",
        FreeTeacherView.as_view(),
        name="free-teachers"
    ),

]