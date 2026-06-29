import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/dashboard_provider.dart';
import 'core/database/database_initializer.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseInitializer.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(),
        ),
      ],
      child: const CoverMeApp(),
    ),
  );
}