/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 2:15 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:convert';

Map<String, dynamic> convertToMap(dynamic inputText) {

  return inputText as Map<String, dynamic>;
}

dynamic convertToJson(String inputText) {

  return jsonDecode(inputText);
}