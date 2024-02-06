/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/17/24, 8:36 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/preferences/io/keys/PreferencesKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesIO {

  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  Future<int> retrieveCategorizedBy() async {

    int categorizedBy = (await _sharedPreferences).getInt(PreferencesKeys.categorizedBy) ?? 0;

    return categorizedBy;
  }

  void storeFibonacciAI(bool inputValue) async {

    (await _sharedPreferences).setBool(PreferencesKeys.fibonacciAI, inputValue);

  }

  Future<bool> retrieveFibonacciAI() async {

    bool fibonacciAI = (await _sharedPreferences).getBool(PreferencesKeys.fibonacciAI) ?? true;

    return fibonacciAI;
  }

}