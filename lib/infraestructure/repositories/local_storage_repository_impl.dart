
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/domain/datasources/datasources.dart';
import 'package:cinemapedia/domain/repositories/repositories.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl({
    required this.datasource
  });

  @override
  Future<List<Movie>> getFavorites({int limit = 10, offset = 0}) {
    return datasource.getFavorites(limit: limit, offset: offset);
  }

  @override
  Future<bool> isInFavorite(int movieId) {
    return datasource.isInFavorite(movieId);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }

}
