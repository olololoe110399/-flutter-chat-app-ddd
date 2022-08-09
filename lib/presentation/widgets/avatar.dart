import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    required this.radius,
    Key? key,
    this.url,
    this.file,
    this.onTap,
  }) : super(key: key);

  const Avatar.small({
    Key? key,
    this.url,
    this.file,
    this.onTap,
  })  : radius = 18,
        super(key: key);

  const Avatar.medium({
    Key? key,
    this.url,
    this.file,
    this.onTap,
  })  : radius = 26,
        super(key: key);

  const Avatar.large({
    Key? key,
    this.url,
    this.file,
    this.onTap,
  })  : radius = 34,
        super(key: key);

  final double radius;
  final String? url;
  final File? file;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _avatar(context),
    );
  }

  Widget _avatar(BuildContext context) {
    if ((url ?? '').isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url!),
        backgroundColor: Theme.of(context).cardColor,
      );
    }

    if (file != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(file!),
        backgroundColor: Theme.of(context).cardColor,
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).cardColor,
      child: Center(
        child: Text(
          '?',
          style: TextStyle(fontSize: radius),
        ),
      ),
    );
  }
}
