
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      name: MoviesScreen.name,
      builder: (context, state) => const MoviesScreen(),
      routes: const []
    ),

  ]
);