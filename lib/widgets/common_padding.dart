//flutter
import 'package:flutter/material.dart';

class CommonPadding extends StatelessWidget {
  final double? left;
  final double? right;
  final double? bottom;
  final Widget? child;
  const CommonPadding({super.key, this.left, this.right, this.bottom, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: child,
    );
  }
}
