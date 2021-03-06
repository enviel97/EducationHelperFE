import 'package:flutter/material.dart';

class RouterAnimation extends PageRouteBuilder {
  final Widget child;

  RouterAnimation({required this.child})
      : super(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(begin: const Offset(-.75, 0), end: Offset.zero)
            .animate(CurvedAnimation(
          curve: Curves.elasticOut,
          parent: animation,
        )),
        child: child,
      );
}
