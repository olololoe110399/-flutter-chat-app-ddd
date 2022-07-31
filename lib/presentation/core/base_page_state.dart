import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../application/common/common.dart';
import '../../application/core/base_bloc.dart';
import '../../inejection.dart';
import '../../shared/shared.dart';
import '../navigator/navigator.dart';

abstract class BasePageState<T extends StatefulWidget, B extends BaseBloc>
    extends BasePageStateDelegete<T, B> {}

abstract class BasePageStateDelegete<T extends StatefulWidget, B extends BaseBloc> extends State<T>
    with AutomaticKeepAliveClientMixin {
  late final AppNavigator navigator = getIt.get<AppNavigator>();

  late final CommonBloc commonBloc = getIt.get<CommonBloc>();

  late final B bloc = getIt.get<B>()
    ..navigator = navigator
    ..commonBloc = commonBloc;

  bool isAppWidget = false;

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!isAppWidget) {
      AppDimen.of(context);
    }

    return Provider(
      create: (_) => navigator,
      child: BlocProvider(
        create: (_) => bloc,
        child: buildPageListener(
          child: isAppWidget
              ? buildPage(context)
              : Stack(
                  children: [
                    buildPage(context),
                    BlocBuilder<CommonBloc, CommonState>(
                      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                      builder: (context, state) => Visibility(
                        visible: state.isLoading,
                        child: buildPageLoading(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildPageListener({required Widget child}) => child;

  Widget buildPage(BuildContext context);

  Widget buildPageLoading() => const Center(
        child: CircularProgressIndicator(),
      );
}
