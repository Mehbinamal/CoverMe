from .models import Teacher, Timetable


class AvailabilityService:

    @staticmethod
    def get_available_teachers(timetable_id):

        current_period = Timetable.objects.get(
            id=timetable_id
        )

        busy_teacher_ids = Timetable.objects.filter(
            day=current_period.day,
            period=current_period.period
        ).values_list(
            "teacher_id",
            flat=True
        )

        preferred = Teacher.objects.filter(
            timetable_entries__classroom=current_period.classroom
        ).exclude(
            id__in=busy_teacher_ids
        ).distinct()

        others = Teacher.objects.exclude(
            id__in=busy_teacher_ids
        ).exclude(
            id__in=preferred.values_list(
                "id",
                flat=True
            )
        )

        return preferred, others