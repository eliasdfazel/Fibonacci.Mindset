/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/22/24, 12:33 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class RhythmDataStructure {

  static const String taskTitleName = "taskTitle";
  static const String taskDescriptionName = "taskDescription";

  static const String taskLocationName = "taskLocation";

  static const String taskPrioritiesName = "taskPriorities";
  static const String taskColorsTagsName = "taskColorsTags";

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

  String taskTitle() {

    return rhythmDocumentData[RhythmDataStructure.taskTitleName];
  }

  String taskDescription() {

    return rhythmDocumentData[RhythmDataStructure.taskDescriptionName];
  }

  String taskLocation() {

    return rhythmDocumentData[RhythmDataStructure.taskLocationName];
  }

  String taskPriorities() {

    return rhythmDocumentData[RhythmDataStructure.taskPrioritiesName];
  }

  String taskColorsTags() {

    return rhythmDocumentData[RhythmDataStructure.taskColorsTagsName];
  }

  /// JSON Array
  String taskAlarmsConfigurations() {

    return rhythmDocumentData[RhythmDataStructure.taskAlarmsConfigurationsName];
  }

}

Map<String, dynamic> rhythmDocument(String taskTitle, String taskDescription, String taskLocation, String taskPriorities, String taskColorsTags, String taskAlarmsConfigurations) {

  return {
    "taskTitle": taskTitle,
    "taskDescription": taskDescription,
    "taskLocation": taskLocation,
    "taskPriorities": taskPriorities,
    "taskColorsTags": taskColorsTags,
    "taskAlarmsConfigurations": taskAlarmsConfigurations,
  };
}