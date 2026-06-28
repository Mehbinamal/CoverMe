from datetime import date

from core.models import (
    Teacher,
    Leave,
    SubstitutionTask,
    Timetable,
)


class DashboardService:

    @staticmethod
    def dashboard():

        hm = Teacher.objects.filter(
            is_hm=True
        ).first()

        today = date.today()

        weekday = today.weekday() + 1

        hm_timetable = []

        if hm:

            hm_timetable = Timetable.objects.filter(
                teacher=hm,
                day=weekday
            ).select_related(
                "classroom",
                "subject"
            )

        return {

            "today": today,

            "leave_count": Leave.objects.filter(
                date=today
            ).count(),

            "pending_count":
            SubstitutionTask.objects.filter(
                status=SubstitutionTask.Status.PENDING
            ).count(),

            "hm_timetable": hm_timetable,

        }