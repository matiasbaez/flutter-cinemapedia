
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infraestructure/datasources/datasources.dart';
import 'package:cinemapedia/infraestructure/repositories/repositories.dart';

// Repository inmutable
final actorRepositoryProvider = Provider((ref) => ActorRepositoryImpl(dataSource: ActorMovieDBDatasource()));
