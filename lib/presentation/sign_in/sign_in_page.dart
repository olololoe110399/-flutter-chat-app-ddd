import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../../application/application.dart';
import '../../shared/shared.dart';
import '../presentation.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends BasePageState<SignInPage, AuthBloc> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildPageListener({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => current.authEntity.isSome(),
          listener: (context, state) {
            state.authEntity.fold(() {}, (auth) {
              AppStreamChat.instance.connectUser(
                token: auth.token,
                user: User(id: auth.user.uid),
              );
              navigator.replace(const MainRoute());
            });
          },
        ),
      ],
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: () => ViewUtils.hideKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).chatter),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimens.d16.responsive()),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: Dimens.d24.responsive(),
                      bottom: Dimens.d24.responsive(),
                    ),
                    child: Text(
                      S.of(context).welcomeBack,
                      style: TextStyle(
                        fontSize: Dimens.d26.responsive(),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.all(Dimens.d8.responsive()),
                        child: TextFormField(
                          onChanged: (value) => bloc.add(AuthEvent.emailChanged(value)),
                          validator: (_) => state.emailAddress.value.fold(
                            (f) => f.maybeMap(
                              empty: (_) => S.of(context).doNotEmpty,
                              invalidEmail: (_) => S.of(context).invalidEmail,
                              orElse: () => null,
                            ),
                            (r) => null,
                          ),
                          decoration: InputDecoration(hintText: S.of(context).email),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                        ),
                      );
                    },
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.all(Dimens.d8.responsive()),
                        child: TextFormField(
                          onChanged: (value) => bloc.add(AuthEvent.passwordChanged(value)),
                          validator: (_) => state.password.value.fold(
                            (f) => f.maybeMap(
                              empty: (_) => S.of(context).doNotEmpty,
                              shortPassword: (_) => S.of(context).shortPassword,
                              orElse: () => null,
                            ),
                            (r) => null,
                          ),
                          decoration: InputDecoration(
                            hintText: S.of(context).password,
                          ),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      );
                    },
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) => previous.isSubmitting != current.isSubmitting,
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.all(Dimens.d8.responsive()),
                        child: state.isSubmitting
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() == true) {
                                    bloc.add(const AuthEvent.signInWithEmailAndPasswordPressed());
                                  }
                                },
                                child: Text(
                                  S.of(context).signIn,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).alreadyHaveAnAccount,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(width: Dimens.d8.responsive()),
                      TextButton(
                        onPressed: () {
                          navigator.push(const SignUpRoute());
                        },
                        child: Text(S.of(context).createAccount),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
