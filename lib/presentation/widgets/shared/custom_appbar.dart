
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/delegates/delegates.dart';

class CustomAppBar extends ConsumerWidget {

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [

              Icon( Icons.movie_outlined, color: colors.primary ),
              const SizedBox( width: 5 ),
              Text('Cinemapedia', style: titleStyle),

              const Spacer(),

              IconButton(
                onPressed: () async {
                  final movieRepository = ref.read(movieRepositoryProvider);
                  final movie = await showSearch<Movie?>(
                    context: context,
                    delegate: SearchMovieDelegate(searchMovies: movieRepository.searchMovies)
                  );

                  if (!context.mounted || movie == null) return;

                  context.push('/movie/${movie.id}');

                },
                icon: const Icon( Icons.search )
              ),

            ],
          ),
        )
      )
    );
  }
}