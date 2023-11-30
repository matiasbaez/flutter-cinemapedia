
import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

class MoviesScreen extends StatelessWidget {

  static const String name = 'movies-screen';

  final Widget childView;

  const MoviesScreen({
    super.key,
    required this.childView
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }

}

