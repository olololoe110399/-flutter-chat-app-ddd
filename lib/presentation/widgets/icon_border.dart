import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class IconBorder extends StatelessWidget {
  const IconBorder({
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
      splashColor: AppColors.secondary,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
          border: Border.all(
            width: Dimens.d2.responsive(),
            color: Theme.of(context).cardColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimens.d4.responsive()),
          child: Icon(
            icon,
            size: Dimens.d22.responsive(),
          ),
        ),
      ),
    );
  }
}
