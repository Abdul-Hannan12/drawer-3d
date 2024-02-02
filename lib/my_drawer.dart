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
  late AnimationController _childAnimationController;
  late AnimationController _drawerAnimationController;

  late Animation<double> _childAnimation;
  late Animation<double> _drawerAnimation;

  @override
  void initState() {
    super.initState();

    _childAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _drawerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _childAnimation = Tween<double>(begin: 0, end: -pi / 2)
        .animate(_childAnimationController);

    _drawerAnimation = Tween<double>(begin: pi / 2.7, end: 0)
        .animate(_drawerAnimationController);
  }

  @override
  void dispose() {
    super.dispose();
    _childAnimationController.dispose();
    _drawerAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double maxDrag = screenWidth * 0.8;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / maxDrag;
        _childAnimationController.value += delta;
        _drawerAnimationController.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_childAnimationController.value < 0.5) {
          _childAnimationController.reverse();
          _drawerAnimationController.reverse();
        } else {
          _childAnimationController.forward();
          _drawerAnimationController.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge(
          [
            _childAnimationController,
            _drawerAnimationController,
          ],
        ),
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                color: const Color(0xFF1a1b26),
              ),
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                    _childAnimationController.value * maxDrag,
                  )
                  ..rotateY(_childAnimation.value),
                child: widget.child,
              ),
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                    -screenWidth + _drawerAnimationController.value * maxDrag,
                  )
                  ..rotateY(_drawerAnimation.value),
                child: widget.drawer,
              ),
            ],
          );
        },
      ),
    );
  }
}
