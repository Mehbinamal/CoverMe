from rest_framework import serializers
from .models import Teacher,Substitution

class TeacherSerializer(serializers.ModelSerializer):

    class Meta:
        model = Teacher
        fields = [
            "id",
            "name",
        ]

class SubstitutionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Substitution
        fields = "__all__"