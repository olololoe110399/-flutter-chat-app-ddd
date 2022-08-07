import 'package:auto_route/auto_route.dart';

import '../../presentation.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(
      page: SplashPage,
      initial: true,
    ),
    mainRouter,
  ],
)
class $AppRouter {}

const mainRouter = CustomRoute<dynamic>(
  transitionsBuilder: TransitionsBuilders.fadeIn,
  durationInMilliseconds: 200,
  page: MainPage,
  children: [
    AutoRoute<dynamic>(
      name: 'BottomTabMessagesRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(
          page: MessagesPage,
          initial: true,
        ),
      ],
    ),
    AutoRoute<dynamic>(
      name: 'BottomTabNotificationsRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(
          page: NotificationsPage,
          initial: true,
        ),
      ],
    ),
    AutoRoute<dynamic>(
      name: 'BottomTabCallsRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(
          page: CallsPage,
          initial: true,
        ),
      ],
    ),
    AutoRoute<dynamic>(
      name: 'BottomTabContactsRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute<dynamic>(
          page: ContactsPage,
          initial: true,
        ),
      ],
    ),
  ],
);
