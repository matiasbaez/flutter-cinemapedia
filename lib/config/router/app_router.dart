
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    ShellRoute(
      builder: (context, state, child) {
        return MoviesScreen(childView: child);
      },
      routes: [

        GoRoute(
          path: '/',
          // name: MoviesScreen.name,
          builder: (context, state) => const MoviesView(),
          routes: [

            GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';
                return MovieScreen(movieId: movieId);
              },
            ),

          ]
        ),

        GoRoute(
          path: '/favorites',
          // name: MoviesScreen.name,
          builder: (context, state) => const FavoriteView(),
        ),

      ]
    ),

  ]
);