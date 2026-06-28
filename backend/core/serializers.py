from rest_framework import serializers

from .models import Teacher, Leave, SubstitutionTask


class TeacherSerializer(serializers.ModelSerializer):

    class Meta:
        model = Teacher
        fields = ["id", "name"]


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
        source="original_teacher.name",
        read_only=True
    )

    classroom = serializers.CharField(
        source="classroom.name",
        read_only=True
    )

    subject = serializers.CharField(
        source="subject.name",
        read_only=True
    )

    substitute = serializers.CharField(
        source="substitute_teacher.name",
        default="",
        read_only=True
    )

    day = serializers.CharField(
        source="get_day_display",
        read_only=True
    )

    class Meta:

        model = SubstitutionTask

        fields = [
            "id",
            "teacher",
            "classroom",
            "subject",
            "period",
            "day",
            "status",
            "substitute",
        ]