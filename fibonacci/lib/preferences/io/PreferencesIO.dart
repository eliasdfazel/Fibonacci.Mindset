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

  Future<int> retrieveAlarmIndex() async {

    int categorizedBy = (await _sharedPreferences).getInt(PreferencesKeys.alarmIndex) ?? 0;

    return categorizedBy;
  }
  Future<bool> storeAlarmIndex(int inputValue) async {

    bool resultSuccess = await (await _sharedPreferences).setInt(PreferencesKeys.alarmIndex, inputValue);

    return resultSuccess;
  }

}