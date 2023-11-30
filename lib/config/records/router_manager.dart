
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class RouterManager {

  static (int, String) getCurrentRouteWithIdx({BuildContext? ctx, int? idx}) {
    assert(ctx != null || idx != null, 'You must provide either the Context or Route Index');

    const Map<int, String> indexedRoutes = {
      0: '/',
      1: '/categories',
      2: '/favorites',
    };

    if (idx != null) {
      final path = indexedRoutes[idx] ?? indexedRoutes[0]!;
      return (idx, path);
    }

    if (ctx != null) {
      final location = GoRouterState.of(ctx).uri.toString();
      int routeIdx = indexedRoutes.keys
      .firstWhere((k) => indexedRoutes[k] == location, orElse: () => 0);

      return (routeIdx, location);
    }

    return (0, indexedRoutes[0]!);
  }

}