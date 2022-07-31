import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/common/common.dart';
import '../../generated/l10n.dart';
import '../../inejection.dart';
import '../../shared/shared.dart';
import '../navigator/navigator.dart';
import '../routes/routes.dart';
import 'core.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({
    required this.appTheme,
    Key? key,
  }) : super(key: key);

  final AppTheme appTheme;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends BasePageState<AppWidget, CommonBloc> {
  final AppRouter _appRouter = getIt.get<AppRouter>();

  @override
  bool get isAppWidget => true;

  @override
  Widget buildPage(BuildContext _) {
    return ScreenUtilInit(
      designSize: const Size(
        UiConstants.designDeviceWidth,
        UiConstants.designDeviceHeight,
      ),
      builder: (_, __) => BlocBuilder<CommonBloc, CommonState>(
        buildWhen: (previous, current) =>
            previous.isDarkTheme != current.isDarkTheme ||
            previous.languageCode != current.languageCode,
        builder: (_, state) => MaterialApp.router(
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
          themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          localeResolutionCallback: (
            Locale? locale,
            Iterable<Locale> supportedLocales,
          ) =>
              supportedLocales.contains(locale) ? locale : Locale(LanguageCode.en.locale),
          locale: Locale(state.languageCode.locale),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
