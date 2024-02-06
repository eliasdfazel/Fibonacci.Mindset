/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:55 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

class CategoriesType {
  static const String typeOne = "Urgent Important";
  static const String typeTwo = "Non-Urgent Important";
  static const String typeThree = "Urgent Non-Important";
  static const String typeFour = "Non-Urgent Non-Important";
}

bool mapContains(List<Map<dynamic, dynamic>> inputListMap, Map<dynamic, dynamic> compareMap) {

  bool itContains = false;

  for (Map<dynamic, dynamic> element in inputListMap) {

    if (element.keys.first == compareMap.keys.first) {

      itContains = true;

    }

  }

  return itContains;
}

String prepareMap(Map<String, dynamic> inputMap) {

  return "{\"${inputMap.keys.first}\":\"${inputMap.values.first}\"}";
}