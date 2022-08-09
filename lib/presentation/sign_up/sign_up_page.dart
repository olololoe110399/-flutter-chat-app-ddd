import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../../application/application.dart';
import '../../shared/shared.dart';
import '../presentation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends BasePageState<SignUpPage, AuthBloc> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget buildPageListener({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => current.authEntity.isSome(),
          listener: (context, state) {
            state.authEntity.fold(() {}, (auth) {
              final streamUser = User(
                id: auth.user.uid,
                name: auth.user.displayName,
                image: auth.user.photoURL,
              );
              AppStreamChat.instance.connectUser(
                token: auth.token,
                user: streamUser,
              );
              AppStreamChat.instance.updateUser(
                user: streamUser,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).chatter),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimens.d16.responsive()),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: Dimens.d24.responsive(),
                    bottom: Dimens.d24.responsive(),
                  ),
                  child: Text(
                    S.of(context).register,
                    style: TextStyle(
                      fontSize: Dimens.d26.responsive(),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      current.fileImage != null &&
                      previous.fileImage?.path != current.fileImage?.path,
                  builder: (context, state) {
                    return Avatar.large(
                      file: state.fileImage,
                      onTap: () => bloc.add(const AuthEvent.pickImage()),
                    );
                  },
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.all(Dimens.d8.responsive()),
                      child: TextFormField(
                        onChanged: (value) => bloc.add(AuthEvent.nameChanged(value)),
                        validator: (_) => state.name.value.fold(
                          (f) => f.maybeMap(
                            empty: (_) => S.of(context).doNotEmpty,
                            orElse: () => null,
                          ),
                          (r) => null,
                        ),
                        decoration: InputDecoration(hintText: S.of(context).name),
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.name, AutofillHints.username],
                      ),
                    );
                  },
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
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.all(Dimens.d8.responsive()),
                      child: state.isSubmitting
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _signUp,
                              child: Text(S.of(context).signUp),
                            ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimens.d16.responsive()),
                  child: const Divider(),
                ),
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
                        navigator.pop();
                      },
                      child: Text(S.of(context).signIn),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      bloc.add(const AuthEvent.registerWithEmailAndPasswordPressed());
    }
  }
}
