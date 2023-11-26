

import 'package:cinemapedia/domain/domain.dart';

abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

}
