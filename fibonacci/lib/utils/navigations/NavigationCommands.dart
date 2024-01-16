/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/11/24, 10:48 AM
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