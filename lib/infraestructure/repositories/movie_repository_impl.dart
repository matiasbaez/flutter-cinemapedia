
import 'package:cinemapedia/domain/repositories/repositories.dart';
import 'package:cinemapedia/domain/datasources/datasources.dart';
import 'package:cinemapedia/domain/entities/entities.dart';

class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDataSource dataSource;

  MovieRepositoryImpl({ required this.dataSource });

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }

}