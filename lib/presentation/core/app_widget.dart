import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entity/enum.dart';
import '../../generated/l10n.dart';
import '../../shared/constants/ui_constants.dart';
import 'navigator/app_navigator_observer.dart';
import 'routes/app_router.dart';
import 'theme/theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({
    required this.appTheme,
    Key? key,
  }) : super(key: key);

  final AppTheme appTheme;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(UiConstants.designDeviceWidth, UiConstants.designDeviceHeight),
      builder: (_, __) => MaterialApp.router(
        builder: (BuildContext context, Widget? child) {
          final data = MediaQuery.of(context);

          return MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: child ?? const SizedBox.shrink(),
          );
        },
        routerDelegate: _appRouter.delegate(
          initialRoutes: [const SplashRoute()],
          navigatorObservers: () => [AppNavigatorObserver()],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: UiConstants.materialTitleApp,
        theme: widget.appTheme.light,
        darkTheme: widget.appTheme.dark,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) =>
            supportedLocales.contains(locale)
                ? locale
                : Locale(
                    LanguageCode.en.locale,
                  ),
        locale: Locale(LanguageCode.en.locale),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}
