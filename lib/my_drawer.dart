import 'package:flutter/material.dart';
import 'dart:math' show pi;

class MyDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  const MyDrawer({super.key, required this.child, required this.drawer});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _childSlideAnimationController;
  late AnimationController _drawerSlideAnimationController;

  late Animation<double> _childRotationAnimation;
  late Animation<double> _drawerRotationAnimation;

  @override
  void initState() {
    super.initState();
    _childSlideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _childRotationAnimation = Tween<double>(begin: 0, end: -pi / 2)
        .animate(_childSlideAnimationController);

    _drawerSlideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _drawerRotationAnimation =
        Tween<double>(begin:  0, end: -pi / 2).animate(_drawerSlideAnimationController);
  }

  @override
  void dispose() {
    super.dispose();
    _childSlideAnimationController.dispose();
    _drawerSlideAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
