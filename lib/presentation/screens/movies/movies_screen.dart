
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideshowMovies = ref.watch(moviesSlideshowProvider);

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
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Soon',
                    subtitle: 'Monday 4',
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Popular',
                    // subtitle: 'Monday 4',
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
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
