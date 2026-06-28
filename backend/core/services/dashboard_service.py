from datetime import date

from core.models import (
    Teacher,
    Leave,
    SubstitutionTask,
)

from .timetable_service import TimetableService


class DashboardService:

    @staticmethod
    def get_dashboard():

        today = date.today()

        weekday = today.weekday() + 1

        hm = Teacher.objects.filter(
            is_hm=True
        ).first()

        timetable = []

        if hm:

            timetable = TimetableService.teacher_timetable(
                hm.id,
                weekday
            )

        return {

            "today": today,

            "leave_count":
            Leave.objects.filter(
                date=today
            ).count(),

            "pending_count":
            SubstitutionTask.objects.filter(
                status=SubstitutionTask.Status.PENDING
            ).count(),

            "hm_timetable":
            timetable,

        }