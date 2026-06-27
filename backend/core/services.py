from django.utils import timezone


from .models import Teacher, Timetable, Substitution



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
    
class SubstitutionService:

    @staticmethod
    def assign_substitute(
        timetable_id,
        substitute_teacher_id
    ):

        timetable = Timetable.objects.get(
            id=timetable_id
        )

        existing = Substitution.objects.filter(
        date=timezone.now().date(),
        original_teacher=timetable.teacher,
        day=timetable.day,
        period=timetable.period,
        ).first()

        if existing:
            return existing

        substitute = Teacher.objects.get(
            id=substitute_teacher_id
        )

        substitution = Substitution.objects.create(

            date=timezone.now().date(),

            classroom=timetable.classroom,

            subject=timetable.subject,

            day=timetable.day,

            period=timetable.period,

            original_teacher=timetable.teacher,

            substitute_teacher=substitute,

        )

        return substitution