import 'package:flutter/material.dart';

/// ════════════════════════════════════════════════════════════════
/// 📐 AppSize - Centralized Responsive Layout & Sizing Helper
/// ════════════════════════════════════════════════════════════════
class AppSize {
  // Base design dimensions (Standard mobile design: 375x812)
  static const double designWidth = 375.0;
  static const double designHeight = 812.0;

  /// Returns the width scale factor based on screen width / 375
  static double scale(BuildContext context) {
    return MediaQuery.sizeOf(context).width / designWidth;
  }

  /// Returns the height scale factor based on screen height / 812
  static double scaleH(BuildContext context) {
    return MediaQuery.sizeOf(context).height / designHeight;
  }

  /// Screen size
  static Size size(BuildContext context) => MediaQuery.sizeOf(context);

  /// Screen width
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  /// Screen height
  static double height(BuildContext context) => MediaQuery.sizeOf(context).height;

  /// Scaled font factor with safety boundaries
  static double fontScale(BuildContext context, {double min = 0.85, double max = 1.25}) {
    return scale(context).clamp(min, max);
  }

  /// Responsive value scaling
  static double s(BuildContext context, double value) => value * scale(context);

  /// Responsive value scaling with safety clamping
  static double clamped(
    BuildContext context,
    double value, {
    double min = 0.85,
    double max = 1.25,
  }) {
    return value * scale(context).clamp(min, max);
  }

  /// Device form factor helpers
  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.sizeOf(context).height < 680 || MediaQuery.sizeOf(context).width < 360;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600;
}

/// ════════════════════════════════════════════════════════════════
/// 💡 Extensions for clean and concise usage in Widgets
/// ════════════════════════════════════════════════════════════════
extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get scale => screenWidth / AppSize.designWidth;
  double get scaleH => screenHeight / AppSize.designHeight;
  double get fontScale => scale.clamp(0.85, 1.25);
  bool get isSmallScreen => screenHeight < 680 || screenWidth < 360;
  bool get isTablet => screenWidth >= 600;

  double s(double value) => value * scale;
  double clamped(double value, {double min = 0.85, double max = 1.25}) =>
      value * scale.clamp(min, max);
}

extension ResponsiveNum on num {
  double w(BuildContext context) => this * context.scale;
  double h(BuildContext context) => this * context.scaleH;
  double sp(BuildContext context) => this * context.fontScale;
}
