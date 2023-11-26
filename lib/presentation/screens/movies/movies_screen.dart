
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class MoviesScreen extends StatelessWidget {

  static const String name = 'movies-screen';

  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(title: const Text('Movies')),
      body: _MoviesView(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

}

class _MoviesView extends ConsumerStatefulWidget {

  const _MoviesView();

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends ConsumerState<_MoviesView> {

  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isLoading = ref.watch(firstLoadingProvider);
    if (isLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideshowMovies = ref.watch(moviesSlideshowProvider);
    final topratedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          snap: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: CustomAppBar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [

                  // const CustomAppBar(),

                  MoviesSlideshow(movies: slideshowMovies),

                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Cines',
                    subtitle: 'Monday 27',
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListView(
                    movies: upcomingMovies,
                    title: 'Soon',
                    subtitle: 'Monday 4',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: 'Popular',
                    // subtitle: 'Monday 4',
                    loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListView(
                    movies: topratedMovies,
                    title: 'Top Rated',
                    // subtitle: 'Monday 4',
                    loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                  ),

                ],
              );
            },
            childCount: 1
          )
        )
      ],
    );
  }
}
