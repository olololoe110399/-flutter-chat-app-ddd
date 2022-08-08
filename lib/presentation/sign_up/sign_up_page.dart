import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../core/core.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends BasePageState<SignUpPage, AuthBloc> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _profilePictureController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailRegex =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _profilePictureController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHATTER'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 24),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    validator: _nameInputValidator,
                    decoration: const InputDecoration(hintText: 'name'),
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.name, AutofillHints.username],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _profilePictureController,
                    decoration: const InputDecoration(hintText: 'picture URL'),
                    keyboardType: TextInputType.url,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: _emailInputValidator,
                    decoration: const InputDecoration(hintText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: _passwordInputValidator,
                    decoration: const InputDecoration(
                      hintText: 'password',
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: const Text('Sign up'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: Theme.of(context).textTheme.subtitle2),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        navigator.pop();
                      },
                      child: const Text('Sign in'),
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
      commonBloc.add(const LoadingChanged(true));
      await Future<dynamic>.delayed(const Duration(seconds: 2));
      commonBloc.add(const LoadingChanged(false));
    }
  }

  String? _nameInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }

    return null;
  }

  String? _emailInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Not a valid email';
    }

    return null;
  }

  String? _passwordInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (value.length <= 6) {
      return 'Password needs to be longer than 6 characters';
    }

    return null;
  }
}
