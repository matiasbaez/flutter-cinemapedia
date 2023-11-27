import 'package:flutter/material.dart';

import 'package:cinemapedia/domain/entities/entities.dart';

class CustomSliverAppBar extends StatelessWidget {

  final Movie movie;

  const CustomSliverAppBar({
    super.key,
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * .7,
      foregroundColor: Colors.white,
      // shadowColor: Colors.red,
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
              ),
            ),

            // Box shadow
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