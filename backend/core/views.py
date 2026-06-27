from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from .serializers import TeacherSerializer, SubstitutionSerializer
from .services import AvailabilityService, SubstitutionService


class FreeTeacherView(APIView):

    def get(self, request):

        timetable_id = request.GET.get("timetable_id")

        preferred, others = (
            AvailabilityService.get_available_teachers(
                timetable_id
            )
        )

        return Response({

            "preferred":
                TeacherSerializer(
                    preferred,
                    many=True
                ).data,

            "others":
                TeacherSerializer(
                    others,
                    many=True
                ).data

        })
    
class AssignSubstituteView(APIView):

    def post(self, request):

        timetable_id = request.data.get(
            "timetable_id"
        )

        substitute_teacher = request.data.get(
            "substitute_teacher_id"
        )

        substitution = (
            SubstitutionService.assign_substitute(
                timetable_id,
                substitute_teacher
            )
        )

        return Response(
            {
                "message":
                "Substitute assigned successfully.",

                "substitution_id":
                substitution.id
            },

            status=status.HTTP_201_CREATED

        )