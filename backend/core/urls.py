from django.urls import path

from .views import AssignSubstituteView, FreeTeacherView

urlpatterns = [

    path(
        "free-teachers/",
        FreeTeacherView.as_view(),
        name="free-teachers"
    ),
    path(
        "substitute/",
        AssignSubstituteView.as_view(),
        name="substitute"
    ),

]