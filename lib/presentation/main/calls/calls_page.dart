import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../core/base_page_state.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends BasePageState<CallsPage, CallsBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold();
  }
}
