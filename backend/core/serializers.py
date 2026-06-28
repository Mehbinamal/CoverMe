from rest_framework import serializers

from .models import (
    Teacher,
    Leave,
    Timetable,
    SubstitutionTask,
)


class TeacherSerializer(serializers.ModelSerializer):

    class Meta:
        model = Teacher
        fields = ["id", "name"]


class TimetableSerializer(serializers.ModelSerializer):

    classroom = serializers.CharField(
        source="classroom.name",
        read_only=True
    )

    subject = serializers.CharField(
        source="subject.name",
        read_only=True
    )

    class Meta:
        model = Timetable
        fields = [
            "id",
            "day",
            "period",
            "classroom",
            "subject",
        ]


class LeaveSerializer(serializers.ModelSerializer):

    teacher_name = serializers.CharField(
        source="teacher.name",
        read_only=True
    )

    class Meta:
        model = Leave
        fields = "__all__"


class TaskSerializer(serializers.ModelSerializer):

    teacher = serializers.CharField(
        source="original_teacher.name"
    )

    classroom = serializers.CharField(
        source="classroom.name"
    )

    subject = serializers.CharField(
        source="subject.name"
    )

    class Meta:
        model = SubstitutionTask

        fields = [
            "id",
            "teacher",
            "classroom",
            "subject",
            "day",
            "period",
            "status",
        ]