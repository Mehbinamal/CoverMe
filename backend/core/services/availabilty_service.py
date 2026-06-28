    

from core.models import Leave, SubstitutionTask, Teacher, Timetable


class AvailabilityService:

    @staticmethod
    def available_teachers(task_id):

        task = SubstitutionTask.objects.select_related(
            "classroom",
            "leave",
            "original_teacher",
        ).get(id=task_id)

        # Teachers who are already teaching during this period
        busy_teacher_ids = list(
            Timetable.objects.filter(
                day=task.day,
                period=task.period
            ).values_list("teacher_id", flat=True)
        )

        # Teachers who are on leave on the same date
        leave_teacher_ids = list(
            Leave.objects.filter(
                date=task.leave.date
            ).values_list("teacher_id", flat=True)
        )

        excluded = set(busy_teacher_ids)
        excluded.update(leave_teacher_ids)
        excluded.add(task.original_teacher_id)

        preferred = Teacher.objects.filter(
            timetable_entries__classroom=task.classroom
        ).exclude(
            id__in=excluded
        ).distinct()

        others = Teacher.objects.exclude(
            id__in=excluded
        ).exclude(
            id__in=preferred.values_list("id", flat=True)
        )

        return preferred, others