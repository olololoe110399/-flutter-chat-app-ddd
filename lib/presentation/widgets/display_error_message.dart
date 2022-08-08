import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import '../presentation.dart';

class DisplayErrorMessage extends StatelessWidget {
  const DisplayErrorMessage({Key? key, this.error}) : super(key: key);

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive()),
        child: Text(
          '${S.of(context).ohNoSomethingWentWrong}\n'
          '${S.of(context).pleaseCheckYourConfigError(error.toString())}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
