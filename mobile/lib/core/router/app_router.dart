import 'package:go_router/go_router.dart';

import '../../screens/main/main_screen.dart';

final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => const MainScreen())],
);
