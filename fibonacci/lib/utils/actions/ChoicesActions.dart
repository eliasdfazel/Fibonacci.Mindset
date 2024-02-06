/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/6/24, 10:01 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

class ChoicesActionsKeys {
  static const int choiceCategory = 0;
  static const int choiceColor = 1;
}

abstract class ChoicesActions {
  void choicesSelected(Map<String, String> choiceInformation, int choiceType) {

  }
  void choicesUnselected(Map<String, String> choiceInformation, int choiceType) {

  }
}