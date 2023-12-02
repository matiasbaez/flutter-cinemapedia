
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/config/helpers/helpers.dart';
import 'package:cinemapedia/domain/entities/entities.dart';

class MovieHorizontalListView extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage
  });

  @override
  State<MovieHorizontalListView> createState() => _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [

          if (widget.title != "" || widget.subtitle != "") _Title(title: widget.title, subtitle: widget.subtitle),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.movies.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final movie = widget.movies[index];
                  return FadeInRight(
                    child: GestureDetector(
                      onTap: () => context.push(Uri(path: '/movie/${movie.id}').toString()),
                      child: _Slide(movie: movie)
                    )
                  );
                }
              ),
            ),
          )

        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subtitle;

  const _Title({
    required this.title,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null) Text(title!, style: titleStyle),
          if (subtitle != null) FilledButton.tonal(
            onPressed: () {},
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            child: Text(subtitle!)
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 8 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: 220,
                fit: BoxFit.cover,
                image: NetworkImage(movie.posterPath),
                placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
              ),
            ),
          ),

          const SizedBox( height: 5 ),

          // Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),

          // Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                const Icon(Icons.star_half_outlined, color: Colors.orange),
                const SizedBox(width: 4),
                Text(HumanFormats.number(movie.voteAverage, 2), style: textStyle.bodyMedium?.copyWith(color: Colors.orange)),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity), style: textStyle.bodySmall)
              ],
            ),
          )

        ],
      ),
    );
  }
}
