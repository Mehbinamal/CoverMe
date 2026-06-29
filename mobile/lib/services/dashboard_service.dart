import '../models/dashboard_model.dart';
import '../models/period_model.dart';

class DashboardService {

  Future<DashboardModel> getDashboard() async {

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    return DashboardModel(

      leaveCount: 3,

      pendingTasks: 5,

      timetable: const [

        PeriodModel(
          period: 1,
          classroom: "10A",
          subject: "Mathematics",
        ),

        PeriodModel(
          period: 2,
        ),

        PeriodModel(
          period: 3,
          classroom: "9B",
          subject: "Physics",
        ),

        PeriodModel(
          period: 4,
          classroom: "Office",
          subject: "",
        ),

      ],

    );

  }

}