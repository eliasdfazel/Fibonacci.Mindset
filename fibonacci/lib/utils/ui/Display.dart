/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/11/24, 10:48 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */ */

import 'package:flutter/material.dart';

double displayLogicalWidth(BuildContext context) {

  return  MediaQuery.of(context).size.width;
}

double displayLogicalHeight(BuildContext context) {

  return  MediaQuery.of(context).size.height;
}

double safeAreaHeight(BuildContext context) {

  var padding = MediaQuery.of(context).padding;

  return displayLogicalHeight(context) - padding.top - padding.bottom;
}

double statusBarHeight(BuildContext context) {

  return MediaQuery.of(context).viewPadding.top;
}