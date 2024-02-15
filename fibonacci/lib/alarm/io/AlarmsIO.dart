/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/3/24, 9:19 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:shared_preferences/shared_preferences.dart';

class AlarmsIO {

  static const String alarmIndex = "alarmIndex";
  static const String alarmRepeatIndex = "alarmRepeatIndex";

  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  Future<int> retrieveAlarmIndex() async {

    int categorizedBy = (await _sharedPreferences).getInt(AlarmsIO.alarmIndex) ?? 0;

    return categorizedBy;
  }
  Future<bool> storeAlarmIndex(int inputValue) async {

    bool resultSuccess = await (await _sharedPreferences).setInt(AlarmsIO.alarmIndex, inputValue);

    return resultSuccess;
  }

  Future<int> retrieveAlarmRepeat() async {

    int categorizedBy = (await _sharedPreferences).getInt(AlarmsIO.alarmRepeatIndex) ?? 0;

    return categorizedBy;
  }
  Future<bool> storeAlarmRepeat(int inputValue) async {

    bool resultSuccess = await (await _sharedPreferences).setInt(AlarmsIO.alarmRepeatIndex, inputValue);

    return resultSuccess;
  }

  Future resetIndexes() async {

    storeAlarmIndex(0);
    storeAlarmRepeat(0);

  }

}