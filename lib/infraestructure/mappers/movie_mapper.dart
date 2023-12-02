import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/infraestructure/models/models.dart';

class MovieMapper {

  static Movie movieDBToEntity(MovieFromMovieDB movie) => Movie(
    adult: movie.adult,
    backdropPath: (movie.backdropPath) != "" ? "https://image.tmdb.org/t/p/w500${movie.backdropPath}" : "https://shorturl.at/rWY16",
    genreIds: movie.genreIds.map((id) => id.toString()).toList(),
    id: movie.id,
    originalLanguage: movie.originalLanguage,
    originalTitle: movie.originalTitle,
    overview: movie.overview,
    popularity: movie.popularity,
    posterPath: (movie.posterPath) != "" ? "https://image.tmdb.org/t/p/w500${movie.posterPath}" : "https://www.movienewz.com/img/films/poster-holder.jpg",
    releaseDate: movie.releaseDate ?? DateTime.now(),
    title: movie.title,
    video: movie.video,
    voteAverage: movie.voteAverage,
    voteCount: movie.voteCount
  );

  static Movie movieDetailToEntity( MovieDetail movie ) => Movie(
    adult: movie.adult,
    backdropPath: (movie.backdropPath) != "" ? "https://image.tmdb.org/t/p/w500${movie.backdropPath}" : "https://shorturl.at/rWY16",
    genreIds: movie.genres.map((genre) => genre.name).toList(),
    id: movie.id,
    originalLanguage: movie.originalLanguage,
    originalTitle: movie.originalTitle,
    overview: movie.overview,
    popularity: movie.popularity,
    posterPath: (movie.posterPath) != "" ? "https://image.tmdb.org/t/p/w500${movie.posterPath}" : "https://www.movienewz.com/img/films/poster-holder.jpg",
    releaseDate: movie.releaseDate,
    title: movie.title,
    video: movie.video,
    voteAverage: movie.voteAverage,
    voteCount: movie.voteCount
  );

}
