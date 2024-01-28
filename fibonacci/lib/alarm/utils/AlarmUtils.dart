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

AlarmSettings setupAlarmSettings(int alarmId,
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