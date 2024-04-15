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
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:flutter/cupertino.dart';

class AlarmProcess {

  static const String alarmTriggered = "alarmTriggered";

}

Future<String> processAlarmsToJson(AlarmsInterface alarmsInterface) async {
  debugPrint("Alarm Inserted: ${alarmsInterface.alarmsInputItems.length}");

  String jsonifyAlarm = "";

  if (alarmsInterface.alarmsInputItems.isNotEmpty
      && alarmsInterface.alarmsDurationInput.first.value.text.isNotEmpty
      && alarmsInterface.alarmsRepeatInput.first.value.text.isNotEmpty
      && alarmsInterface.alarmsRestInput.first.value.text.isNotEmpty) {

    jsonifyAlarm = "[";

    for (int i = 0; i < alarmsInterface.alarmsInputItems.length; i++) {
      debugPrint("Jsonify Alarm: ${i}");

      String eachAlarm = "{"
          "\"index\":$i,"
          "\"${RhythmDataStructure.taskDuration}\":\"${alarmsInterface.alarmsDurationInput[i].value.text}\","
          "\"${RhythmDataStructure.taskRepeat}\":\"${alarmsInterface.alarmsRepeatInput[i].value.text}\","
          "\"${RhythmDataStructure.taskRest}\":\"${alarmsInterface.alarmsRestInput[i].value.text}\""
          "}";

      jsonifyAlarm += eachAlarm;

      if (i < (alarmsInterface.alarmsInputItems.length - 1)) {

        jsonifyAlarm += ",";

      }

    }

    jsonifyAlarm += "]";

  }


  return jsonifyAlarm;
}