import 'dart:math';

import 'package:flutter/material.dart';

class AnimationLogo extends StatefulWidget {
  const AnimationLogo({super.key});

  @override
  State<AnimationLogo> createState() => _AnimationLogoState();
}

class _AnimationLogoState extends State<AnimationLogo> with SingleTickerProviderStateMixin{

    AnimationController? _animationController;

    @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 10));
    _animationController!.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animationController!.value * 2.0 * pi,
          child: Container(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/logo.png"),
              radius: 130,
            ),
          ),
        );
      },
    );
  }
}