import 'package:auto_route/auto_route.dart';

import '../splash/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(
      page: SplashPage,
      initial: true,
    ),
  ],
)
class $AppRouter {}
