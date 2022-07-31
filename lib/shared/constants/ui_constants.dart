import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../enum.dart';

class UiConstants {
  const UiConstants._();

  static late DeviceType deviceType = _getDeviceType();

  static const materialTitleApp = 'My App';
  static const materialColorApp = Color(0xFF36C6A3);
  static const designDeviceWidth = 375.0;
  static const designDeviceHeight = 667.0;

  static const maxMobileWidth = 450;
  static const maxTabletWidth = 900;

  static const maxMobileWidthForDeviceType = 550;

  static const systemUiOverlay = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: Color(0xFF36C6A3),
  );

  static const mobileOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  static const tabletOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];
  static DeviceType _getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

    return data.size.shortestSide < maxMobileWidthForDeviceType
        ? DeviceType.mobile
        : DeviceType.tablet;
  }
}
