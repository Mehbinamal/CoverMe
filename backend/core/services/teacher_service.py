from core.models import Teacher


class TeacherService:

    @staticmethod
    def all_teachers():

        return Teacher.objects.order_by(
            "name"
        )

    @staticmethod
    def search(keyword):

        return Teacher.objects.filter(
            name__icontains=keyword
        ).order_by(
            "name"
        )
    