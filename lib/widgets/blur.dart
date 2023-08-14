import 'dart:ui';
import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  final Widget child;
  const Blur({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: child,
      ),
    );
  }
}
