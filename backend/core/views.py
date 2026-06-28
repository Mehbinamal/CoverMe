from datetime import datetime,date

from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import Teacher
from .serializers import (
    TeacherSerializer,
    LeaveSerializer,
)
from .services import LeaveService,TaskService


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
    
class GenerateTaskView(APIView):

    def post(self, request):

        date_string = request.data.get("date")

        if not date_string:
            return Response(
                {
                    "error": "date is required"
                },
                status=status.HTTP_400_BAD_REQUEST
            )

        try:

            task_date = datetime.strptime(
                date_string,
                "%Y-%m-%d"
            ).date()

        except ValueError:

            return Response(
                {
                    "error": "Invalid date format. Use YYYY-MM-DD."
                },
                status=status.HTTP_400_BAD_REQUEST
            )

        total = TaskService.generate_tasks(task_date)

        return Response(
            {
                "message": "Tasks generated successfully.",
                "tasks_created": total
            }
        )