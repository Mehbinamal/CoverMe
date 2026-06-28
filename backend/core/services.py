from datetime import date

from .models import (
    Leave,
    Timetable,
    SubstitutionTask,
)


class LeaveService:

    @staticmethod
    def todays_leave():

        return Leave.objects.filter(
            date=date.today()
        )
    
class TaskService:

    @staticmethod
    def generate_tasks(for_date):

        weekday = for_date.weekday() + 1

        leaves = Leave.objects.filter(
            date=for_date,
            is_processed=False
        )

        created = 0

        for leave in leaves:

            periods = Timetable.objects.filter(
                teacher=leave.teacher,
                day=weekday
            )

            for period in periods:

                SubstitutionTask.objects.get_or_create(
                    timetable=period,
                    leave=leave,

                    defaults={

                        "original_teacher": period.teacher,

                        "classroom": period.classroom,

                        "subject": period.subject,

                        "day": period.day,

                        "period": period.period,

                        "status": SubstitutionTask.Status.PENDING

                    }
                )
                created += 1

            leave.is_processed = True
            leave.save()

        return created
    
class DashboardService:

    @staticmethod
    def pending_tasks():

        return SubstitutionTask.objects.filter(
            status=SubstitutionTask.Status.PENDING
        ).select_related(
            "original_teacher",
            "classroom",
            "subject"
        )