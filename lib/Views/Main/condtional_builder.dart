import 'dart:math';
import 'package:flutter/material.dart';


class AnimatedConditionalBuilder extends StatelessWidget {
  final bool condition ;
  final WidgetBuilder builder ;
  final WidgetBuilder? fallback ;
  final Duration? duration , reverseDuration ;
  final Curve? switchInCurve , switchOutCurve ;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder ;
  final AnimatedSwitcherLayoutBuilder? layoutBuilder ;


  const AnimatedConditionalBuilder({
    required this.condition ,
    required this.builder ,
    required this.fallback ,
    this.duration ,
    this.reverseDuration ,
    this.switchOutCurve ,
    this.switchInCurve ,
    this.layoutBuilder ,
    this.transitionBuilder ,
    Key? key
  }) : super(key : key) ;


  @override
  AnimatedSwitcher build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration ?? const Duration(milliseconds: 400) ,
      reverseDuration: reverseDuration ?? duration ,
      switchInCurve: switchInCurve ?? Curves.linear ,
      switchOutCurve: switchOutCurve ?? Curves.linear ,
      transitionBuilder: transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder ,
      layoutBuilder: layoutBuilder ?? AnimatedSwitcher.defaultLayoutBuilder ,
      child: condition ?
      builder(context)
          :
      Visibility(
          visible: fallback == null ? false : true ,
          child: fallback == null ? const SizedBox(): fallback!(context)
      ),
    );
  }

  // generate random between minimum and maximum
  int generateRandom({required int min, required int max,}) {
    return min + Random.secure().nextInt(max - min);
  }
}


class AnimatedVisibility extends StatelessWidget {
  final Widget child;
  final bool visible;
  final Duration? duration , reverseDuration ;
  final Curve? switchInCurve , switchOutCurve ;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder ;
  final AnimatedSwitcherLayoutBuilder? layoutBuilder ;


  const AnimatedVisibility({
    Key? key ,
    required this.visible ,
    required this.child ,
    this.duration ,
    this.reverseDuration ,
    this.switchInCurve ,
    this.switchOutCurve ,
    this.layoutBuilder ,
    this.transitionBuilder
  }) : super(key: key);

  @override
  AnimatedSwitcher build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration ?? const Duration(milliseconds: 400) ,
      reverseDuration: reverseDuration ?? duration ,
      switchInCurve: switchInCurve ?? Curves.linear ,
      switchOutCurve: switchOutCurve ?? Curves.linear ,
      transitionBuilder: transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder ,
      layoutBuilder: layoutBuilder ?? AnimatedSwitcher.defaultLayoutBuilder ,
      child: Visibility(
          visible: visible ,
          key: ValueKey<bool>(visible) ,
          child: child
      ),
    );
  }
}