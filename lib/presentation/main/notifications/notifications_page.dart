import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../core/base_page_state.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends BasePageState<NotificationsPage, NotificationsBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold();
  }
}
