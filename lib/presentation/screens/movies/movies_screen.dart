
import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

class MoviesScreen extends StatefulWidget {

  static const String name = 'movies-screen';

  final Widget childView;

  const MoviesScreen({
    super.key,
    required this.childView
  });

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {

    super.build(context);

    return Scaffold(
      body: widget.childView,
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

