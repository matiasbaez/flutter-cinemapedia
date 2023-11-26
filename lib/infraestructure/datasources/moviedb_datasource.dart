
import 'package:dio/dio.dart';

import 'package:cinemapedia/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia/infraestructure/mappers/mappers.dart';
import 'package:cinemapedia/domain/datasources/datasources.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/entities.dart';

class MovieDBDatasource extends MoviesDataSource {

  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es'
    }
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing');
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != "no-poster")
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }

}