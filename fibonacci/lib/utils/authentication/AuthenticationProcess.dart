/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/14/24, 8:54 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fibonacci/profile/database/directory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationsCallback {
  void authenticationWithGoogleCompleted();
}

class AuthenticationsProcess {

  Future<UserCredential> startGoogleAuthentication() async {
    debugPrint("Start Google Authentication Process");

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuthentication = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuthentication?.accessToken,
      idToken: googleAuthentication?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void createProfiles(String emailAddress) {

    FirebaseFirestore.instance.doc(profilesDocumentPath(emailAddress))
        .set({
          emailAddress: emailAddress.toString()
        });

  }

}