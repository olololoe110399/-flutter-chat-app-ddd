import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../inejection.dart';
import '../../shared/shared.dart';
import 'routes/routes.dart';

@LazySingleton()
class AppNavigator {
  AppNavigator();

  final tabsRoutes = const [
    BottomTabMessagesRouter(),
    BottomTabNotificationsRouter(),
    BottomTabCallsRouter(),
    BottomTabContactsRouter(),
  ];

  static final popups = <Popup>{};

  TabsRouter? tabsRouter;

  final AppRouter _appRouter = getIt.get<AppRouter>();
  StackRouter? get _currentTabRouter =>
      tabsRouter?.stackRouterOfIndex(tabsRouter?.activeIndex ?? 0);

  StackRouter get _currentTabRouterOrRootRouter => _currentTabRouter ?? _appRouter;

  BuildContext get _rootRouterContext => _appRouter.navigatorKey.currentContext!;

  BuildContext? get _currentTabRouterContext => _currentTabRouter?.navigatorKey.currentContext;

  BuildContext get _currentTabContextOrRootContext =>
      _currentTabRouterContext ?? _rootRouterContext;

  bool get canPopSelfOrChildren => _appRouter.canPopSelfOrChildren;

  void popUntilRootOfCurrentTab() {
    if (tabsRouter == null) {
      throw 'Not found any TabRouter';
    }

    if (_currentTabRouter?.canPopSelfOrChildren == true) {
      _currentTabRouter?.popUntilRoot();
    }
  }

  Future<T?> push<T extends Object?>(PageRouteInfo pageRouteInfo) {
    return _appRouter.push<T>(pageRouteInfo);
  }

  Future<void> pushAll(List<PageRouteInfo> listPageRouteInfo) {
    return _appRouter.pushAll(listPageRouteInfo);
  }

  Future<T?> replace<T extends Object?>(PageRouteInfo pageRouteInfo) {
    return _appRouter.replace<T>(pageRouteInfo);
  }

  Future<void> replaceAll(List<PageRouteInfo> listPageRouteInfo) {
    return _appRouter.replaceAll(listPageRouteInfo);
  }

  Future<bool> pop<T extends Object?>({T? result, bool useRootNavigator = false}) {
    return useRootNavigator
        ? _appRouter.pop<T>(result)
        : _currentTabRouterOrRootRouter.pop<T>(result);
  }

  Future<T?> popAndPush<T extends Object?, R extends Object?>(
    PageRouteInfo pageRouteInfo, {
    R? result,
    bool useRootNavigator = false,
  }) {
    return useRootNavigator
        ? _appRouter.popAndPush<T, R>(pageRouteInfo, result: result)
        : _currentTabRouterOrRootRouter.popAndPush<T, R>(
            pageRouteInfo,
            result: result,
          );
  }

  void popUntilRoot({bool useRootNavigator = false}) {
    useRootNavigator ? _appRouter.popUntilRoot() : _currentTabRouterOrRootRouter.popUntilRoot();
  }

  void popUntilRouteName(String routeName) {
    _appRouter.popUntilRouteWithName(routeName);
  }

  bool removeUntilRouteName(String routeName) {
    return _appRouter.removeUntil((route) => route.name == routeName);
  }

  bool removeAllRoutesWithName(String routeName) {
    return _appRouter.removeWhere((route) => route.name == routeName);
  }

  Future<void> popAndPushAll(List<PageRouteInfo> listPageRouteInfo) {
    return _appRouter.popAndPushAll(listPageRouteInfo);
  }

  bool removeLast() {
    return _appRouter.removeLast();
  }

  Future<T?> showAppDialog<T extends Object?>(
    Popup type, {
    required Widget child,
    bool barrierDismissible = true,
    bool useSafeArea = false,
    bool useRootNavigator = true,
  }) {
    if (popups.contains(type)) {
      debugPrint('Dialog $type already shown');

      return Future.value(null);
    }
    popups.add(type);

    return showDialog<T>(
      context: useRootNavigator ? _rootRouterContext : _currentTabContextOrRootContext,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          debugPrint('Dialog $type dismissed');
          popups.remove(type);

          return Future.value(true);
        },
        child: child,
      ),
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
    );
  }

  Future<T?> showGeneralAppDialog<T extends Object?>(
    Popup type, {
    required Widget child,
    Duration transitionDuration = DurationConstants.tutorialAnimtionDuration,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transitionBuilder,
    Color? barrierColor,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) {
    if (popups.contains(type)) {
      debugPrint('Dialog $type already shown');

      return Future.value(null);
    }
    popups.add(type);

    return showGeneralDialog<T>(
      context: useRootNavigator ? _rootRouterContext : _currentTabContextOrRootContext,
      barrierColor: barrierColor ?? AppColors.c000000.withOpacity(0.6),
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2,
      ) =>
          WillPopScope(
        onWillPop: () async {
          debugPrint('Dialog $type dismissed');
          popups.remove(type);

          return Future.value(true);
        },
        child: child,
      ),
      transitionBuilder: transitionBuilder,
      transitionDuration: transitionDuration,
    );
  }

  Future<T?> showBottomSheet<T extends Object?>({
    required Widget Function(BuildContext) builder,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color barrierColor = Colors.black54,
    AnimationController? transitionAnimationController,
  }) {
    return showModalBottomSheet<T>(
      context: useRootNavigator ? _rootRouterContext : _currentTabContextOrRootContext,
      builder: builder,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useRootNavigator: useRootNavigator,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor,
      transitionAnimationController: transitionAnimationController,
    );
  }

  void showErrorSnackBar(String message, {Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
      backgroundColor: AppColors.cFF6E65,
    );
  }

  void showSuccessSnackBar(String message, {Duration? duration}) {
    ViewUtils.showAppSnackBar(
      _rootRouterContext,
      message,
      duration: duration,
      backgroundColor: AppColors.c36C6A3,
    );
  }
}
