
import 'package:isar/isar.dart';

import 'package:path_provider/path_provider.dart';

import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/domain/datasources/datasources.dart';

class IsarDatasource extends LocalStorageDatasource {

  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {

    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [ MovieSchema ],
        inspector: true,
        directory: dir.path
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favorite = await isar.movies.filter().idEqualTo(movie.id).findFirst();

    // Delete from favorites
    if (favorite != null) {
      isar.writeTxnSync(() async => isar.movies.deleteSync( favorite.isarId! ));
      return;
    }

    // Add to favorites
    isar.writeTxnSync(() => isar.movies.putSync(movie));

  }

  @override
  Future<bool> isInFavorite(int movieId) async {

    final isar = await db;
    final Movie? result = await isar.movies.filter().idEqualTo(movieId).findFirst();

    return (result != null);
  }

  @override
  Future<List<Movie>> getFavorites({ int limit = 10, offset = 0 }) async {

    final isar = await db;
    final List<Movie> movies = await isar.movies.where().offset(offset).limit(limit).findAll();

    return movies;
  }

}
