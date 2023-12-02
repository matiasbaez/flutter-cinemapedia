import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/config.dart';
import 'package:cinemapedia/config/router/app_router.dart';

Future<void> main() async {

  await dotenv.load(fileName: '.env');

  runApp(
    const ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    initializeDateFormatting();

    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Cinemapedia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appTheme(),
    );
  }
}
