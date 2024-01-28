/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/28/24, 11:11 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:alarm/alarm.dart';
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/utils/modifications/Strings.dart';

class AlarmUtils {

  void setupAlarm(RhythmDataStructure rhythmDataStructure, int alarmIndex,
      {String alarmSoundAsset = 'assets/sparkle.ogg'}) async {

    if (await Alarm.isRinging(rhythmDataStructure.taskId())) {

      await Alarm.stop(rhythmDataStructure.taskId());

    } else {

      List listOfAlarm = List.from(convertToJsonDynamic(rhythmDataStructure.taskAlarmsConfigurations()));

      if (alarmIndex < listOfAlarm.length) {

        int alarmDuration = int.parse(listOfAlarm[alarmIndex][RhythmDataStructure.taskDuration]);

        Future.delayed(const Duration(microseconds: 777), () async {

          AlarmSettings alarmSettings = _setupAlarmSettings(rhythmDataStructure.taskId(), rhythmDataStructure.taskTitle(), rhythmDataStructure.taskDescription(),
              DateTime.now().add(Duration(minutes: alarmDuration)));

          await Alarm.setNotificationOnAppKillContent(rhythmDataStructure.taskTitle(), rhythmDataStructure.taskDescription());

          await Alarm.set(alarmSettings: alarmSettings);

        });

      }

    }

  }

  AlarmSettings _setupAlarmSettings(int alarmId,
      String alarmTitle, String alarmDescription,
      DateTime alarmDateTime,
      {String alarmSoundAsset = 'assets/sparkle.ogg'}) {

    return AlarmSettings(
      id: alarmId,
      dateTime: alarmDateTime,
      assetAudioPath: alarmSoundAsset,
      loopAudio: true,
      vibrate: true,
      volume: 0.37,
      fadeDuration: 3.7,
      notificationTitle: alarmTitle,
      notificationBody: alarmDescription,
      androidFullScreenIntent: true,
      enableNotificationOnKill: true,
    );
  }

}