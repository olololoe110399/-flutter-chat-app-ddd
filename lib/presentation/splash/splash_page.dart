import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../presentation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, AuthBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const AuthEvent.authCheckRequested());
  }

  @override
  Widget buildPageListener({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            state.map(
              initial: (_) {},
              authenticated: (auth) {
                AppStreamChat.instance.connectUser(
                  id: auth.authEntity.user.uid,
                  token: auth.authEntity.token,
                );
                navigator.replace(const MainRoute());
              },
              unauthenticated: (_) {
                navigator.replace(const SignInRoute());
              },
            );
          },
        ),
      ],
      child: child,
    );
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
