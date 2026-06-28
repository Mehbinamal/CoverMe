from datetime import date

from core.models import Leave


class LeaveService:

    @staticmethod
    def today():

        return Leave.objects.filter(
            date=date.today()
        )

    @staticmethod
    def all():

        return Leave.objects.all()