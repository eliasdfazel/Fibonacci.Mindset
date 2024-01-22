/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/22/24, 11:06 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fibonacci/profile/database/ProfileDirectory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationsCallback {
  void authenticatedByGoogle();
}

class AuthenticationsProcess {

  Future<UserCredential> startGoogleAuthentication(AuthenticationsCallback authenticationsCallback) async {
    debugPrint("Start Google Authentication Process");

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuthentication = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuthentication?.accessToken,
      idToken: googleAuthentication?.idToken,
    );

    var userCredentials =  await FirebaseAuth.instance.signInWithCredential(credential);

    authenticationsCallback.authenticatedByGoogle();

    return userCredentials;
  }

  void createProfiles(String emailAddress) {

    FirebaseFirestore.instance.doc(profilesDocumentPath(emailAddress))
        .set({
          'emailAddress': emailAddress.toString()
        });

  }

}