/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/21/24, 11:00 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

bool mapContains(List<Map<dynamic, dynamic>> inputListMap, Map<dynamic, dynamic> compareMap) {

  bool itContains = false;

  for (Map<dynamic, dynamic> element in inputListMap) {

    if (element.keys.first.contains(compareMap.keys.first)) {

      itContains = true;

      break;
    }

  }

  return itContains;
}