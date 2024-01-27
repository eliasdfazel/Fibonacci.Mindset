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

  static const String taskTitleName = "taskTitle";
  static const String taskDescriptionName = "taskDescription";

  static const String taskLocationName = "taskLocation";

  static const String taskCategoriesName = "taskCategories";
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

  String taskCategories() {

    return rhythmDocumentData[RhythmDataStructure.taskCategoriesName];
  }

  String taskColorsTags() {

    return rhythmDocumentData[RhythmDataStructure.taskColorsTagsName];
  }

  /// JSON Array
  String taskAlarmsConfigurations() {

    return rhythmDocumentData[RhythmDataStructure.taskAlarmsConfigurationsName];
  }

}

Map<String, dynamic> rhythmDocument(String taskTitle, String taskDescription, String taskLocation, String taskCategories, String taskColorsTags, String taskAlarmsConfigurations) {

  return {
    "taskTitle": taskTitle,
    "taskDescription": taskDescription,
    "taskLocation": taskLocation,
    "taskCategories": taskCategories,
    "taskColorsTags": taskColorsTags,
    "taskAlarmsConfigurations": taskAlarmsConfigurations,
  };
}