
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/domain/datasources/datasources.dart';
import 'package:cinemapedia/domain/repositories/repositories.dart';

class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDataSource dataSource;

  ActorRepositoryImpl({
    required this.dataSource
  });

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return dataSource.getActorsByMovie(movieId);
  }
}
