from core.models import Timetable


class TimetableService:

    @staticmethod
    def teacher_timetable(
        teacher_id,
        day=None
    ):

        qs = Timetable.objects.filter(
            teacher_id=teacher_id
        )

        if day:

            qs = qs.filter(
                day=day
            )

        return qs.select_related(
            "classroom",
            "subject"
        ).order_by(
            "day",
            "period"
        )