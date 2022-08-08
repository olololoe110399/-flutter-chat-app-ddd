import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../shared/shared.dart';
import '../presentation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage, AuthBloc> {
  @override
  Widget buildPage(BuildContext context) {
    final user = AppStreamChat.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
        leading: Center(
          child: IconBackground(
            icon: Icons.arrow_back_ios_new,
            onTap: () => navigator.pop(),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: 'hero-profile-picture',
              child: Avatar.large(url: user?.image),
            ),
            Padding(
              padding: EdgeInsets.all(Dimens.d8.responsive()),
              child: Text(user?.name ?? S.of(context).noName),
            ),
            const Divider(),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.isSubmitting
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: _signOut,
                        child: Text(S.of(context).signOut),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      AppStreamChat.instance.disconnectUser();
      bloc.add(const AuthEvent.signedOut());
    } on Exception catch (e, st) {
      logE(e, stackTrace: st);
    }
  }
}
