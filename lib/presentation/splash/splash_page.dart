import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

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
          listener: (context, state) {
            state.authenticated.fold(
              () => navigator.replace(
                const SignInRoute(),
              ),
              (f) {
                f.fold(
                  () => navigator.replace(const SignInRoute()),
                  (authEntity) {
                    AppStreamChat.instance.connectUser(
                      user: User(id: authEntity.user.uid),
                      token: authEntity.token,
                    );
                    navigator.replace(const MainRoute());
                  },
                );
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
