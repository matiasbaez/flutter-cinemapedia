
import 'dart:async';

import 'package:cinemapedia/config/helpers/helpers.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/domain/entities/entities.dart';

class Suggestion {

  final String name;
  final String? lastName;
  final double? price;
  final String? imageUrl;

  Suggestion({
    required this.name,
    this.lastName = '',
    this.price = 0,
    this.imageUrl = 'https://www.unfe.org/wp-content/uploads/2019/04/SM-placeholder.png'
  });

}

typedef SearchMoviesCallback = Future<List<Movie>> Function( String query );

class SearchMovieDelegate extends SearchDelegate<Movie?> {


  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast(); // For multiple subscriptions
  Timer? _dounceTimer;

  SearchMovieDelegate({
    super.searchFieldLabel,
    super.searchFieldStyle,
    super.searchFieldDecorationTheme,
    super.keyboardType,
    super.textInputAction,
    required this.searchMovies,
    required this.initialMovies
  });

  void _onQueryChanged( String query ) {
    // reset timer is query change (user is writing)
    if (_dounceTimer?.isActive ?? false)  _dounceTimer!.cancel();

    // make request if the user is not writing anymore
    _dounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        // if (query.isEmpty) {
        //   debounceMovies.add([]);
        //   return;
        // }

        final movies = await searchMovies(query);
        initialMovies = movies;
        debounceMovies.add(movies);
      }
    );
  }

  void clearStreams() {
    debounceMovies.close();
  }

  // @override
  // void dispose() {
  //   clearStreams();
  //   super.dispose();
  // }

  @override
  String? get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [

      if (query.isNotEmpty)
        FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = '';
              // close(context, null);
            }
          ),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Colors.grey
      ),
      tooltip: 'Back',
      onPressed: () {
        clearStreams();
        close(context, null);
      },
    );
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {

            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onMovieSelected: () {
                clearStreams();
                close(context, movie);
              },
            );

          }
        );
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return buildResultsAndSuggestions();
  }

}


class _MovieItem extends StatelessWidget {

  final Movie movie;
  final VoidCallback? onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onMovieSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [

            // Image
            SizedBox(
              width: size.width * .2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return FadeIn(child: child);
                  },
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Description
            SizedBox(
              width: size.width * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    movie.title,
                    style: textStyles.titleMedium
                  ),

                  // subtitle
                  (movie.overview.length > 100)
                  ? Text('${movie.overview.substring(0, 100)}...')
                  : Text(movie.overview),

                  // stars
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 2),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ]
              ),
            )

          ],
        )
      ),
    );
  }
}
