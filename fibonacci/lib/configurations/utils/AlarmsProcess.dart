/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 1:15 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/configurations/ui/sections/Alarms.dart';

Future<String> processAlarmsToJson(AlarmsInterface alarmsInterface) async {

  String jsonifyAlarm = "[";

  for (int i = 0; i < alarmsInterface.alarmsInputItems.length; i++) {

    String eachAlarm = "duration\"${alarmsInterface.alarmsDurationInput[i].value.text}\""
        "";

  }

  jsonifyAlarm = "]";

  return jsonifyAlarm;
}