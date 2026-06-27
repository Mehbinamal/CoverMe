import csv

from django.core.management.base import BaseCommand

from core.models import Teacher, Classroom, Subject, Timetable, Day


DAY_MAP = {
    "MON": Day.MONDAY,
    "TUE": Day.TUESDAY,
    "WED": Day.WEDNESDAY,
    "THU": Day.THURSDAY,
    "FRI": Day.FRIDAY,
}


class Command(BaseCommand):
    help = "Import timetable from CSV"

    def add_arguments(self, parser):
        parser.add_argument(
            "csv_file",
            type=str,
            help="Path to timetable CSV file",
        )

    def handle(self, *args, **options):

        csv_file = options["csv_file"]

        imported = 0

        with open(csv_file, newline="", encoding="utf-8-sig") as file:

            reader = csv.DictReader(file)

            for row in reader:

                teacher, _ = Teacher.objects.get_or_create(
                    name=row["Teacher"].strip()
                )

                classroom, _ = Classroom.objects.get_or_create(
                    name=row["Class"].strip()
                )

                subject, _ = Subject.objects.get_or_create(
                    name=row["Subject"].strip()
                )

                Timetable.objects.get_or_create(
                    teacher=teacher,
                    classroom=classroom,
                    subject=subject,
                    day=DAY_MAP[row["Day"].strip()],
                    period=int(row["Period"]),
                )

                imported += 1

        self.stdout.write(
            self.style.SUCCESS(
                f"Successfully imported {imported} timetable entries."
            )
        )