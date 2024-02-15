/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 1:16 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class RhythmDataStructure {

  static const String taskDuration = "taskDuration";
  static const String taskRepeat = "taskRepeat";
  static const String taskRest = "taskRest";

  static const String taskIdName = "taskId";

  static const String taskTitleName = "taskTitle";
  static const String taskDescriptionName = "taskDescription";

  static const String taskLocationName = "taskLocation";

  static const String taskCategoriesName = "taskCategories";
  static const String taskColorsTagsName = "taskColorsTags";

  static const String taskAlarmTypeName = "taskAlarmType";
  static const String taskAlarmTypeManual = "AlarmType_Manual";
  static const String taskAlarmTypeFibonacci = "AlarmType_Fibonacci";

  /// JSON Format
  static const String taskAlarmsConfigurationsName = "taskAlarmsConfigurations";

  DocumentSnapshot? documentSnapshot;
  Map<String, dynamic> rhythmDocumentData = <String, dynamic>{};

  RhythmDataStructure(DocumentSnapshot inputDocumentSnapshot) {

    documentSnapshot = inputDocumentSnapshot;
    rhythmDocumentData = inputDocumentSnapshot.data() as Map<String, dynamic>;

  }

  String? documentId() {

    return documentSnapshot?.id;
  }

  int taskId() {

    return rhythmDocumentData[RhythmDataStructure.taskIdName];
  }

  String taskTitle() {

    return rhythmDocumentData[RhythmDataStructure.taskTitleName];
  }

  String taskDescription() {

    return rhythmDocumentData[RhythmDataStructure.taskDescriptionName];
  }

  String taskLocation() {

    return rhythmDocumentData[RhythmDataStructure.taskLocationName];
  }

  String taskCategories() {

    return rhythmDocumentData[RhythmDataStructure.taskCategoriesName];
  }

  String taskColorsTags() {

    return rhythmDocumentData[RhythmDataStructure.taskColorsTagsName];
  }

  String taskAlarmType() {

    return rhythmDocumentData[RhythmDataStructure.taskAlarmTypeName];
  }

  /// JSON Array
  dynamic taskAlarmsConfigurations() {

    return rhythmDocumentData[RhythmDataStructure.taskAlarmsConfigurationsName];
  }

}

Map<String, dynamic> rhythmDocument(int taskId, String taskTitle, String taskDescription, String taskLocation, String taskCategories, String taskColorsTags, String taskAlarmsConfigurations, String taskAlarmType) {

  return {
    "taskId": taskId,
    "taskTitle": taskTitle,
    "taskDescription": taskDescription,
    "taskLocation": taskLocation,
    "taskCategories": taskCategories,
    "taskColorsTags": taskColorsTags,
    "taskAlarmsConfigurations": taskAlarmsConfigurations,
    "taskAlarmType": taskAlarmType
  };
}