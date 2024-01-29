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
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/utils/modifications/Strings.dart';

class AlarmUtils {

  void nextAlarmProcess(RhythmDataStructure rhythmDataStructure, PreferencesIO preferencesIO) async {

    if (await Alarm.isRinging(rhythmDataStructure.taskId())) {

      await Alarm.stop(rhythmDataStructure.taskId());

    } else {

      List listOfAlarm = List.from(convertToJsonDynamic(rhythmDataStructure.taskAlarmsConfigurations()));

      int alarmIndex = await preferencesIO.retrieveAlarmIndex();

      if (alarmIndex < listOfAlarm.length) {

        int repeatIndex = await preferencesIO.retrieveAlarmRepeat();

        int alarmRepeat = int.parse(listOfAlarm[alarmIndex][RhythmDataStructure.taskRepeat]);

        if (repeatIndex < alarmRepeat) {

          await preferencesIO.storeAlarmRepeat(repeatIndex + 1);

          setupAlarm(rhythmDataStructure, listOfAlarm[alarmIndex + 1][RhythmDataStructure.taskDuration]);

        } else {

          await preferencesIO.storeAlarmRepeat(0);

          if (alarmIndex < listOfAlarm.length) {

            await preferencesIO.storeAlarmIndex(alarmIndex + 1);

            setupAlarm(rhythmDataStructure, listOfAlarm[alarmIndex + 1][RhythmDataStructure.taskDuration]);

          }

        }

      } else {

        //Reset Alarm Index
        await preferencesIO.storeAlarmIndex(0);

        await preferencesIO.storeAlarmRepeat(0);

      }

    }

  }

  void revertAlarmProcess(RhythmDataStructure rhythmDataStructure, PreferencesIO preferencesIO) async {

    if (await Alarm.isRinging(rhythmDataStructure.taskId())) {

      await Alarm.stop(rhythmDataStructure.taskId());

    } else {

      List listOfAlarm = List.from(convertToJsonDynamic(rhythmDataStructure.taskAlarmsConfigurations()));

      int repeatIndex = await preferencesIO.retrieveAlarmRepeat();

      if (repeatIndex > 0) {

        int alarmIndex = await preferencesIO.retrieveAlarmRepeat();

        await preferencesIO.storeAlarmRepeat(repeatIndex - 1);

        setupAlarm(rhythmDataStructure, listOfAlarm[alarmIndex][RhythmDataStructure.taskDuration], prefix: "Revert One Step");

      } else {

        await preferencesIO.storeAlarmRepeat(0);

        int alarmIndex = await preferencesIO.retrieveAlarmRepeat();

        if (alarmIndex < listOfAlarm.length) {

          if ((alarmIndex - 1) > 0) {

            setupAlarm(rhythmDataStructure, listOfAlarm[alarmIndex - 1][RhythmDataStructure.taskDuration], prefix: "Revert One Step");

          } else {

            setupAlarm(rhythmDataStructure, listOfAlarm[0][RhythmDataStructure.taskDuration], prefix: "Revert One Step");

          }

        }

      }

    }

  }

  void restAlarmProcess(RhythmDataStructure rhythmDataStructure, PreferencesIO preferencesIO) async {

    if (await Alarm.isRinging(rhythmDataStructure.taskId())) {

      await Alarm.stop(rhythmDataStructure.taskId());

    } else {

      List listOfAlarm = List.from(convertToJsonDynamic(rhythmDataStructure.taskAlarmsConfigurations()));

      int alarmIndex = await preferencesIO.retrieveAlarmIndex();

      setupAlarm(rhythmDataStructure, listOfAlarm[alarmIndex][RhythmDataStructure.taskRest], prefix: "Resting");

    }

  }

  void setupAlarm(RhythmDataStructure rhythmDataStructure, int alarmDuration, {String prefix = ""}) {

    Future.delayed(const Duration(microseconds: 777), () async {

      AlarmSettings alarmSettings = _setupAlarmSettings(rhythmDataStructure.taskId(), "${rhythmDataStructure.taskTitle()} - $prefix", rhythmDataStructure.taskDescription(),
          DateTime.now().add(Duration(minutes: alarmDuration)));

      await Alarm.setNotificationOnAppKillContent(rhythmDataStructure.taskTitle(), rhythmDataStructure.taskDescription());

      await Alarm.set(alarmSettings: alarmSettings);

    });

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