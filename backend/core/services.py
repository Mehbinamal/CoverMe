from datetime import date

from .models import Leave


class LeaveService:

    @staticmethod
    def todays_leave():

        return Leave.objects.filter(
            date=date.today()
        )