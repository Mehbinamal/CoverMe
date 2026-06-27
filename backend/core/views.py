from rest_framework.views import APIView
from rest_framework.response import Response

from .serializers import TeacherSerializer
from .services import AvailabilityService


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