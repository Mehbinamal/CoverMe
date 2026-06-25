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


class Substitution(models.Model):
    date = models.DateField()

    classroom = models.ForeignKey(
        Classroom,
        on_delete=models.CASCADE,
    )

    subject = models.ForeignKey(
        Subject,
        on_delete=models.CASCADE,
    )

    day = models.IntegerField(
        choices=Day.choices,
    )

    period = models.PositiveSmallIntegerField()

    original_teacher = models.ForeignKey(
        Teacher,
        on_delete=models.CASCADE,
        related_name="given_substitutions",
    )

    substitute_teacher = models.ForeignKey(
        Teacher,
        on_delete=models.CASCADE,
        related_name="received_substitutions",
    )

    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = [
            "-date",
            "period",
        ]

    def __str__(self):
        return (
            f"{self.date} | "
            f"{self.classroom} | "
            f"P{self.period} | "
            f"{self.original_teacher} → {self.substitute_teacher}"
        )