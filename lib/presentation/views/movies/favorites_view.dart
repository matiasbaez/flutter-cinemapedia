
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class FavoriteView extends ConsumerStatefulWidget {

  const FavoriteView({super.key});

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends ConsumerState<FavoriteView> {


  bool isLoading = false;
  bool isLastPage = false;

  void loadNextPage() async {

    if (isLoading || isLastPage) return;

    isLoading = true;

    final movies = await ref.read( favoriteMoviesProvider.notifier ).loadNextPage();

    isLoading = false;

    isLastPage = movies.isEmpty;

  }

  @override
  void initState() {
    super.initState();

    loadNextPage();

  }

  @override
  Widget build(BuildContext context) {

    final favoriteMovies = ref.watch( favoriteMoviesProvider ).values.toList();

    if ( favoriteMovies.isEmpty ) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Icon( Icons.favorite_outline_sharp, size: 60, color: colors.primary ),
            Text('Ohhh no!!', style: TextStyle( fontSize: 30, color: colors.primary)),
            const Text('You dont have any movie as favorite', style: TextStyle( fontSize: 20, color: Colors.black45 )),

            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go('/'),
              child: const Text('Start searching')
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies,
        loadNextPage: loadNextPage
      )
    );
  }
}