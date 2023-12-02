import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/helpers/helpers.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const String name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();

    if (widget.movieId != 'no-id') {
      ref.read(movieDetailProvider.notifier).loadMovieDetail(widget.movieId);
      ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.movieId == 'no-id') {
      return Center(
        child: Column(
          children: [
            const Text('No se ha encontrado ninguna pelicula'),
            FilledButton(
              onPressed: () => context.pop(),
              child: const Text('Go back')
            )
          ],
        ),
      );
    }

    final Movie? movie = ref.watch(movieDetailProvider)[widget.movieId];

    if (movie == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Searching movie...'),
            const SizedBox(height: 10),

            const CircularProgressIndicator(),

            const SizedBox(height: 10),

            FilledButton.icon(
              onPressed: () {
                context.pop();
              },
              label: const Text('Go back'),
              icon: const Icon( Icons.arrow_back_ios_new_outlined ),
            ),
          ]
        )
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [

          CustomSliverAppBar(movie: movie),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1
            )
          ),

        ],
      ),
    );
  }
}


class _MovieDetails extends StatelessWidget {

  final Movie movie;

  const _MovieDetails({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _TitleAndOverview(movie: movie, size: size, textStyle: textStyle),

        // Genres
        _Genres(movie: movie),

        // Movie Actors
        ActorsByMovie(movieId: movie.id.toString()),

        // Videos of the movie
        VideosFromMovieDB( movieId: movie.id ),

        // Similar movies
        SimilarMovies(movieId: movie.id ),

        // const SizedBox(height: 50),

      ],
    );
  }
}

class _TitleAndOverview extends StatelessWidget {

  const _TitleAndOverview({
    required this.movie,
    required this.size,
    required this.textStyle,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Movie Picture
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              width: size.width * .3,
            ),
          ),

          const SizedBox( width: 10 ),

          // Description
          SizedBox(
            width: (size.width - 40) * .7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyle.titleLarge, textAlign: TextAlign.justify),
                Text(movie.overview),

                const SizedBox(height: 10 ),

                MovieRating(voteAverage: movie.voteAverage ),

                Row(
                  children: [
                    const Text('Estreno:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5 ),
                    Text(HumanFormats.shortDate(movie.releaseDate))
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class _Genres extends StatelessWidget {

  const _Genres({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          children: [
            ...movie.genreIds.map((gender) => Container(
              margin: const EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(gender),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            )).toList()
          ],
        ),
      ),
    );
  }
}
