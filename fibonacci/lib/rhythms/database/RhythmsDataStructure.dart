/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 9:14 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class RhythmDataStructure {

  static const String taskTitleName = "taskTitle";
  static const String taskDescriptionName = "taskDescription";

  static const String taskLocationName = "taskLocation";

  static const String taskCategoryName = "taskCategory";
  static const String taskColorTagName = "taskColorTag";

  /// JSON Format
  static const String taskAlarmsConfigurationsName = "taskAlarmsConfigurations";

  Map<String, dynamic> rhythmDocumentData = <String, dynamic>{};

  RhythmDataStructure(DocumentSnapshot documentSnapshot) {

    rhythmDocumentData = documentSnapshot.data() as Map<String, dynamic>;

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

  String taskCategory() {

    return rhythmDocumentData[RhythmDataStructure.taskCategoryName];
  }

  String taskColorTag() {

    return rhythmDocumentData[RhythmDataStructure.taskColorTagName];
  }

  /// JSON Array
  String taskAlarmsConfigurations() {

    return rhythmDocumentData[RhythmDataStructure.taskAlarmsConfigurationsName];
  }

}