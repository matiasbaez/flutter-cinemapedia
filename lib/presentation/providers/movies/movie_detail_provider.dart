
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final movieDetailProvider = StateNotifierProvider<MovieNotifier, Map<String, Movie>>((ref) {
  final getMovieDetail = ref.watch(movieRepositoryProvider).getMovieById;
  return MovieNotifier(getMovieDetail: getMovieDetail);
});

// Use case
typedef MovieDetailCallback = Future<Movie> Function(String id);

class MovieNotifier extends StateNotifier<Map<String, Movie>> {

  bool isLoading = false;
  final MovieDetailCallback getMovieDetail;

  MovieNotifier({
    required this.getMovieDetail
  }) : super({});

  Future<void> loadMovieDetail(String movieId) async {
    if (isLoading) return;

    isLoading = true;

    if ( state[movieId] != null ) {
      isLoading = false;
      return;
    }

    final Movie movie = await getMovieDetail(movieId);

    isLoading = false;

    state = {...state, movieId: movie};
  }

}
