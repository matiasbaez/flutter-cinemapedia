import 'package:flutter/material.dart';

import 'package:isar/isar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

// With .family can receive an argument
// With .autoDispose the state is reseted
final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId ) {
  final localStorage = ref.watch(localStorageProvider);
  return localStorage.isInFavorite(movieId);
});

class CustomSliverAppBar extends ConsumerWidget {

  final Movie movie;

  const CustomSliverAppBar({
    super.key,
    required this.movie
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    final favoriteProvider = ref.watch( isFavoriteProvider(movie.id) );

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * .7,
      foregroundColor: Colors.white,
      // shadowColor: Colors.red,
      actions: [
        IconButton(
          onPressed: () {

            ref.watch( localStorageProvider ).toggleFavorite(movie)
            .then((value) {

              // Invalidate the provider state to return to initial state
              // This make the "request" again
              ref.invalidate(isFavoriteProvider(movie.id));

            });

          },
          icon: favoriteProvider.when(
            data: (isFavorite) => isFavorite ? const Icon( Icons.favorite, color: Colors.red ) : const Icon( Icons.favorite_border ),
            error: (error, stacktrace) => const Icon( Icons.favorite_border ),
            loading: () => const Icon( Icons.favorite_border )
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: <Widget>[

            // Movie Picture
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();

                  return FadeIn(child: child);
                }
              ),
            ),

            // Box shadow
            const _BoxShadow(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [
                Colors.black54,
                Colors.transparent
              ],
            ),

            const _BoxShadow(),

            const _BoxShadow(
              stops: [0.0, 0.3],
              begin: Alignment.topLeft,
              colors: [ Colors.black87, Colors.transparent ],
            ),

          ]
        ),
      ),
    );
  }
}

class _BoxShadow extends StatelessWidget {

  final List<Color>? gradientColors;
  final List<double>? gradientStops;
  final Alignment? alignmentEnd;
  final Alignment? alignmentBegin;

  const _BoxShadow({
    colors,
    stops,
    end = Alignment.bottomCenter,
    begin = Alignment.topCenter
  }) : gradientColors = colors ?? const [Colors.transparent, Colors.black87],
       gradientStops = stops ?? const [0.5, 1.0],
       alignmentEnd = end ?? Alignment.bottomCenter,
       alignmentBegin = begin ?? Alignment.topCenter;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: alignmentBegin!,
            end: alignmentEnd!,
            stops: gradientStops,
            colors: gradientColors!,
          )
        ),
      ),
    );
  }
}