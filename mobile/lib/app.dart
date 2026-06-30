import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class CoverMeApp extends StatelessWidget {
  const CoverMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "CoverMe",

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      routerConfig: router,
    );
  }
}
