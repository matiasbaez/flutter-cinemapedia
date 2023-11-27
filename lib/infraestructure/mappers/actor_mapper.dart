
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/infraestructure/models/models.dart';

class ActorMapper {

  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}' : 'https://shorturl.at/bitN7',
    character: cast.character,
  );

}
