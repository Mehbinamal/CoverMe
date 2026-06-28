from rest_framework import serializers

from .models import Teacher, Leave


class TeacherSerializer(serializers.ModelSerializer):

    class Meta:
        model = Teacher
        fields = [
            "id",
            "name",
        ]


class LeaveSerializer(serializers.ModelSerializer):

    teacher_name = serializers.CharField(
        source="teacher.name",
        read_only=True
    )

    class Meta:
        model = Leave
        fields = [
            "id",
            "teacher",
            "teacher_name",
            "date",
            "reason",
        ]