import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class IconBackground extends StatelessWidget {
  const IconBackground({
    required this.icon,
    required this.onTap,
    this.size = 18,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimens.d6.responsive()),
        splashColor: AppColors.secondary,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(Dimens.d6.responsive()),
          child: Icon(
            icon,
            size: size,
          ),
        ),
      ),
    );
  }
}
