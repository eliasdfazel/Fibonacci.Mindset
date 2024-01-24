/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:05 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';

Future<dynamic> navigateTo(BuildContext context, StatefulWidget statefulWidget) {

  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => statefulWidget),
  );
}

void navigateToWithPop(BuildContext context, StatefulWidget statefulWidget) {

  Navigator.pop(context);

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => statefulWidget),
  );

}

void navigatePop(BuildContext context) {

  Navigator.pop(context);

}

void navigatePopWithResult(BuildContext context, dynamic result) {

  Navigator.pop(context, result);

}

void navigateToWithSlideAnimation(BuildContext context, StatefulWidget statefulWidget) {

  Navigator.of(context).push(PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 555),
    pageBuilder: (context, animation, secondaryAnimation) => statefulWidget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      Animatable<Offset> animationOffset = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.ease));

      return SlideTransition(
        position: animation.drive(animationOffset),
        child: child
      );
    },
  ));
}

void navigateToWithFadeAnimation(BuildContext context, StatefulWidget statefulWidget) {

  Navigator.of(context).push(PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 555),
    pageBuilder: (context, animation, secondaryAnimation) => statefulWidget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      Animatable<double> opacityAnimation = Tween(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: Curves.ease));

      return FadeTransition(
          opacity: animation.drive(opacityAnimation),
          child: child
      );
    },
  ));
}