import 'package:flutter/material.dart';

import '../../application/common/common.dart';
import '../core/core.dart';
import 'splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, SplashBloc> {
  @override
  void initState() {
    super.initState();
    commonBloc.add(const CommonEvent.loadingVisibity(true));
    Future.delayed(const Duration(seconds: 3), () {
      commonBloc.add(const CommonEvent.loadingVisibity(false));
      commonBloc.add(const CommonEvent.appThemeChanged(true));
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('splash screen'),
      ),
    );
  }
}
