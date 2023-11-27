
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final getMovieDetail = ref.watch(actorRepositoryProvider).getActorsByMovie;
  return ActorsByMovieNotifier(getActorByMovie: getMovieDetail);
});

// Use case
typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {

  bool isLoading = false;
  final GetActorsCallback getActorByMovie;

  ActorsByMovieNotifier({
    required this.getActorByMovie
  }) : super({});

  Future<void> loadActors(String movieId) async {
    if (isLoading) return;

    isLoading = true;

    if ( state[movieId] != null ) return;

    final List<Actor> actors = await getActorByMovie(movieId);

    isLoading = false;

    state = {...state, movieId: actors};
  }

}
