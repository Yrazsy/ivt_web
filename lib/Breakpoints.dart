import 'package:flutter/material.dart';

class Breakpoints {
  static const mobile = 600.0;
  static const tablet = 1024.0;
  static const desktop = 1440.0;
}

extension ResponsiveExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  bool get isMobile => width < Breakpoints.mobile;

  bool get isTablet =>
      width >= Breakpoints.mobile &&
          width < Breakpoints.tablet;

  bool get isDesktop =>
      width >= Breakpoints.desktop;
}