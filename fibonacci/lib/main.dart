/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/14/24, 10:00 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fibonacci/EntryConfigurations.dart';
import 'package:fibonacci/dashboard/ui/Dashboard.dart';
import 'package:fibonacci/firebase_options.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
  debugPrint("Sachiels Signal Received: ${remoteMessage.data}");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

}

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  var firebaseInitialized = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile
      || connectivityResult == ConnectivityResult.wifi
      || connectivityResult == ConnectivityResult.vpn
      || connectivityResult == ConnectivityResult.ethernet) {

    try {

      final internetLookup = await InternetAddress.lookup('example.com');

      bool connectionResult = (internetLookup.isNotEmpty && internetLookup[0].rawAddress.isNotEmpty);

      await FirebaseAuth.instance.currentUser?.reload();

      Widget entryPlaceholder = EntryConfigurations(internetConnection: connectionResult);

      if (FirebaseAuth.instance.currentUser == null) {
        debugPrint("Entry Configurations");

        entryPlaceholder = EntryConfigurations(internetConnection: connectionResult);

      } else {
        debugPrint("Dashboard");

        entryPlaceholder = DashboardInterface(internetConnection: connectionResult);

      }

      runApp(
          Phoenix(
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: StringsResources.applicationName(),
                  color: ColorsResources.primaryColor,
                  theme: ThemeData(
                    fontFamily: 'Ubuntu',
                    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
                    pageTransitionsTheme: const PageTransitionsTheme(builders: {
                      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                    }),
                  ),
                  home: entryPlaceholder
              )
          )
      );

    } on SocketException catch (exception) {
      debugPrint(exception.message);


    }

  }

}