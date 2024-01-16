/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 9:25 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */ */

import 'package:flutter/material.dart';

Color convertToColor(String hexColor) {

  String color = hexColor.replaceAll('#', '0xff');
  return Color(int.parse(color));
}