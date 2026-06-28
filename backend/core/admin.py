from django.contrib import admin

# Register your models here.
from .models import (
    Teacher,
    Classroom,
    Subject,
    Timetable,
    Leave,
    SubstitutionTask,
)


admin.site.register(Teacher)
admin.site.register(Classroom)
admin.site.register(Subject)
admin.site.register(Timetable)
admin.site.register(Leave)
admin.site.register(SubstitutionTask)