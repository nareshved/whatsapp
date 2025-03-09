import 'package:flutter/material.dart';

class ResponsiveApp extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveApp({super.key, required this.desktop, required this.mobile});

  // using media query get current platform screen width/height
  static Size mqResponsive(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

  /// using layout builder get current platform screen width/height

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight > constraints.maxWidth) {
          return mobile;
        } else {
          return desktop;
        }
      },
    );
  }
}

/// using orientiation builder
class AppOrientiation extends StatelessWidget {
  const AppOrientiation(
      {super.key, required this.portrait, required this.landscape});

  final Widget portrait;
  final Widget landscape;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return portrait;
        } else {
          return landscape;
        }
      },
    );
  }
}
