import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../splash/splash_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(
      page: SplashPage,
      initial: true,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
