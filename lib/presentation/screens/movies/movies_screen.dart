
import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {

  static const String name = 'movies-screen';

  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
    );
  }

}
