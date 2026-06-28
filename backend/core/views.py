from datetime import date

from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Teacher
from .serializers import (
    TeacherSerializer,
    LeaveSerializer,
)
from .services import LeaveService


class TeacherListView(APIView):

    def get(self, request):

        teachers = Teacher.objects.all()

        return Response(
            TeacherSerializer(
                teachers,
                many=True
            ).data
        )


class LeaveView(APIView):

    def get(self, request):

        leaves = LeaveService.todays_leave()

        return Response(
            LeaveSerializer(
                leaves,
                many=True
            ).data
        )

    def post(self, request):

        serializer = LeaveSerializer(
            data=request.data
        )

        if serializer.is_valid():

            serializer.save()

            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )

        return Response(
            serializer.errors,
            status=status.HTTP_400_BAD_REQUEST
        )