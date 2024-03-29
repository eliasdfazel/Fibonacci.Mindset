
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
import 'package:status_bar_control/status_bar_control.dart';

void changeColor(Color statusBarColor, Color navigationBarColor) {

  StatusBarControl.setColor(statusBarColor, animated: true);

  StatusBarControl.setNavigationBarColor(navigationBarColor, animated: true);

}