
import 'package:dio/dio.dart';

import 'package:cinemapedia/infraestructure/mappers/mappers.dart';
import 'package:cinemapedia/domain/datasources/datasources.dart';
import 'package:cinemapedia/infraestructure/models/models.dart';
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

  List<Movie> jsonToMovies(Map<String, dynamic> json) {

    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != "no-poster")
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: { 'page': page });
    return jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: { 'page': page });
    return jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: { 'page': page });
    return jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: { 'page': page });
    return jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    if (response.statusCode != 200) throw Exception('Movie with id: $id not found');

    final movieDB = MovieDetail.fromJson(response.data);
    final movie = MovieMapper.movieDetailToEntity(movieDB);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get('/search/movie', queryParameters: { 'query': query });
    return jsonToMovies(response.data);
  }

}