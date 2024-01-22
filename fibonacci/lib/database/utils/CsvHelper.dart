/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/22/24, 12:21 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/configurations/ui/sections/elements/Choices.dart';

String csvProcess(List<Choices> listOfColorsTags) {

  String csvResult = "";

  for (Choices element in listOfColorsTags) {

    if (element.choiceSelected) {

      csvResult += "${element.choiceInformation},";

    }

  }

  return csvResult;
}

Future<String> csvCleanup(String csvInput) async {

  return csvInput;
}