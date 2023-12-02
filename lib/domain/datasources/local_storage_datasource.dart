
import 'package:cinemapedia/domain/entities/entities.dart';

abstract class LocalStorageDatasource {

  Future<void> toggleFavorite( Movie movie );
  Future<bool> isInFavorite( int movieId );
  Future<List<Movie>> getFavorites({ int limit = 10, offset = 0 });

}