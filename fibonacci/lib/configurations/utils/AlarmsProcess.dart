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

Future<String> processAlarmsToJson(AlarmsInterface alarmsInterface) async {

  String jsonifyAlarm = "[";

  for (int i = 0; i < alarmsInterface.alarmsInputItems.length; i++) {

    String eachAlarm = "{"
        "\"index\":$i"
        "\"${RhythmDataStructure.taskDuration}\":\"${alarmsInterface.alarmsDurationInput[i].value.text}\""
        "\"${RhythmDataStructure.taskRepeat}\":\"${alarmsInterface.alarmsRepeatInput[i].value.text}\""
        "\"${RhythmDataStructure.taskRest}\":\"${alarmsInterface.alarmsRestInput[i].value.text}\""
        "}";

    jsonifyAlarm += "$eachAlarm,";

  }

  jsonifyAlarm = "]";

  return jsonifyAlarm;
}