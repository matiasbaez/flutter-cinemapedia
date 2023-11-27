
import 'package:dio/dio.dart';

import 'package:cinemapedia/infraestructure/mappers/mappers.dart';
import 'package:cinemapedia/infraestructure/models/models.dart';
import 'package:cinemapedia/domain/datasources/datasources.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/entities.dart';

class ActorMovieDBDatasource extends ActorsDataSource {

  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es'
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/casts');
    final credits = CreditsResponse.fromJson(response.data);
    List<Actor> actors = credits.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();
    return actors;
  }

}
