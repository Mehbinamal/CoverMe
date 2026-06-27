from django.db import models


class Day(models.IntegerChoices):
    MONDAY = 1, "Monday"
    TUESDAY = 2, "Tuesday"
    WEDNESDAY = 3, "Wednesday"
    THURSDAY = 4, "Thursday"
    FRIDAY = 5, "Friday"


class Teacher(models.Model):
    name = models.CharField(max_length=100)
    department = models.CharField(max_length=100, blank=True)

    def __str__(self):
        return self.name


class Classroom(models.Model):
    name = models.CharField(max_length=20, unique=True)

    def __str__(self):
        return self.name


class Subject(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Timetable(models.Model):
    teacher = models.ForeignKey(
        Teacher,
        on_delete=models.CASCADE,
        related_name="timetable_entries",
    )

    classroom = models.ForeignKey(
        Classroom,
        on_delete=models.CASCADE,
        related_name="timetable_entries",
    )

    subject = models.ForeignKey(
        Subject,
        on_delete=models.CASCADE,
        related_name="timetable_entries",
    )

    day = models.IntegerField(
        choices=Day.choices,
    )

    period = models.PositiveSmallIntegerField()

    class Meta:
        unique_together = (
            "teacher",
            "day",
            "period",
        )

        ordering = [
            "day",
            "period",
        ]

    def __str__(self):
        return f"{self.teacher} - {self.classroom} - {self.subject} ({self.get_day_display()} P{self.period})"


class Leave(models.Model):

    teacher=models.ForeignKey(
        Teacher,
        on_delete=models.CASCADE
    )

    date=models.DateField()

    reason=models.CharField(
        max_length=100,
        blank=True
    )

    created_at=models.DateTimeField(
        auto_now_add=True
    )

class SubstitutionTask(models.Model):

    class Status(models.TextChoices):
        PENDING="PENDING","Pending"
        ASSIGNED="ASSIGNED","Assigned"

    timetable=models.ForeignKey(
        Timetable,
        on_delete=models.CASCADE
    )

    leave=models.ForeignKey(
        Leave,
        on_delete=models.CASCADE
    )

    substitute_teacher=models.ForeignKey(
        Teacher,
        null=True,
        blank=True,
        on_delete=models.SET_NULL
    )

    status=models.CharField(
        max_length=20,
        choices=Status.choices,
        default=Status.PENDING
    )

    created_at=models.DateTimeField(
        auto_now_add=True
    )