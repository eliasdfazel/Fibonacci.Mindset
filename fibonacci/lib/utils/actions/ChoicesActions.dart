/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/6/24, 10:01 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/configurations/ui/sections/elements/CategoriesChoices.dart';
import 'package:fibonacci/configurations/ui/sections/elements/ColorsChoices.dart';

class ChoicesActionsKeys {
  static const int choiceCategory = 0;
  static const int choiceColor = 1;
}

abstract class CategoryChoicesActions {
  void choicesSelected(CategoriesChoices choiceInformation, int choiceType) {

  }
  void choicesUnselected(CategoriesChoices choiceInformation, int choiceType) {

  }
}

abstract class ColorsChoicesActions {
  void choicesSelected(ColorsChoices choiceInformation, int choiceType) {

  }
  void choicesUnselected(ColorsChoices choiceInformation, int choiceType) {

  }
}