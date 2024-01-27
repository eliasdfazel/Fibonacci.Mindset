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
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/database/rhythms/RhythmsDirectory.dart';
import 'package:firebase_auth/firebase_auth.dart';

void generatePrototypes() {

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "UIX", "#00ff00", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "UIX", "#30ff00", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "UIX", "#00ff0g", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "Dev", "#00ff00", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "Dev", "#00fgg0", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "Dev", "#00ff05", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "Dev", "#00ff00", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "Marketing", "#00ff07", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "Marketing", "#00ff07", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "Marketing", "#00ff00", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "Marketing", "#00ff00", "")
  );

  FirebaseFirestore.instance.collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!)).add(
      rhythmDocument("Geeks Empire", "Some Tasks Should Be Done!", "Work Station", "Marketing", "#00ff00", "")
  );

}