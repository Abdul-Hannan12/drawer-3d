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
    _drawerRotationAnimation = Tween<double>(begin: pi / 2, end: 0)
        .animate(_drawerSlideAnimationController);
  }

  @override
  void dispose() {
    super.dispose();
    _childSlideAnimationController.dispose();
    _drawerSlideAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double maxDrag = screenWidth * 0.8;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _childSlideAnimationController.value += details.delta.dx / maxDrag;
        _drawerSlideAnimationController.value += details.delta.dx / maxDrag;
      },
      onHorizontalDragEnd: (details) {
        if (_childSlideAnimationController.value < 0.5) {
          _childSlideAnimationController.reverse();
          _drawerSlideAnimationController.reverse();
        } else {
          _childSlideAnimationController.forward();
          _drawerSlideAnimationController.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge(
          [
            _childSlideAnimationController,
            _drawerSlideAnimationController,
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
                    _childSlideAnimationController.value * maxDrag,
                  )
                  ..rotateY(_childRotationAnimation.value),
                child: widget.child,
              ),
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                    -screenWidth +
                        _drawerSlideAnimationController.value * maxDrag,
                  )
                  ..rotateY(_drawerRotationAnimation.value),
                child: widget.drawer,
              ),
            ],
          );
        },
      ),
    );
  }
}
