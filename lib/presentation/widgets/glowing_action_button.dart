import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class GlowingActionButton extends StatelessWidget {
  const GlowingActionButton({
    required this.color,
    required this.icon,
    required this.onPressed,
    Key? key,
    this.size = 54,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: Dimens.d8.responsive(),
            blurRadius: Dimens.d24.responsive(),
          ),
        ],
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: AppColors.cardLight,
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(
                icon,
                size: Dimens.d26.responsive(),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
