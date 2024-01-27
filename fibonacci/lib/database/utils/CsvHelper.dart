/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 11:57 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/configurations/ui/sections/elements/ColorsChoices.dart';

String csvProcess(List<ColorsChoices> listOfColorsTags) {

  String csvResult = "";

  for (ColorsChoices element in listOfColorsTags) {

    if (element.choiceSelected) {

      csvResult += "${element.choiceInformation},";

    }

  }

  return csvResult;
}

Future<String> csvCleanup(String csvInput) async {

  return csvInput;
}