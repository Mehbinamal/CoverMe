import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/dashboard_provider.dart';
import 'providers/teacher_provider.dart';
import 'core/database/database_initializer.dart';
import 'providers/teacher_details_provider.dart';
import 'providers/leave_provider.dart';
import 'providers/task_provider.dart';
import 'providers/assignment_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseInitializer.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => TeacherProvider()),
        ChangeNotifierProvider(create: (_) => TeacherDetailsProvider()),
        ChangeNotifierProvider(create: (_) => LeaveProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => AssignmentProvider()),
      ],
      child: const CoverMeApp(),
    ),
  );
}
