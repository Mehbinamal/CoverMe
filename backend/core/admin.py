from django.contrib import admin

# Register your models here.
from .models import (
    Teacher,
    Classroom,
    Subject,
    Timetable,
    Substitution,
)


admin.site.register(Teacher)
admin.site.register(Classroom)
admin.site.register(Subject)
admin.site.register(Timetable)
admin.site.register(Substitution)