

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/domain/repositories/repositories.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final favoriteMoviesProvider = StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageProvider);
  return FavoriteMoviesNotifier(localStorageRepository: localStorageRepository);
});


class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  int page = 0;
  final LocalStorageRepository localStorageRepository;

  FavoriteMoviesNotifier({
    required this.localStorageRepository
  }) : super({});

  Future<List<Movie>> loadNextPage() async {

    final movies = await localStorageRepository.getFavorites(offset: page * 10, limit: 20);
    page++;

    final result = <int, Movie>{};
    for ( final movie in movies ) {
      result[movie.id] = movie;
    }

    state = {...state, ...result };

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieFavorite = state[movie.id] != null;

    if (isMovieFavorite) {
      state.remove(movie.id);
      state = { ...state };
      return;
    }

    state = { ...state, movie.id: movie };
  }

}
