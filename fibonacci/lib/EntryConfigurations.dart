/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/14/24, 7:43 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/ui/system_bars.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class EntryConfigurations extends StatefulWidget {

  bool internetConnection = false;

  EntryConfigurations({Key? key, required this.internetConnection}) : super(key: key);

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationState();
}
class _EntryConfigurationState extends State<EntryConfigurations> {

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

    authenticationProcess();

    requestNotificationPermission();

    setupInteractedMessage();

  }

  @override
  Widget build(BuildContext context) {

    if (widget.internetConnection) {

      FlutterNativeSplash.remove();


    } else {

      FlutterNativeSplash.remove();

    }

    return SafeArea(
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
            home: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorsResources.black,
                body: Stack(
                    children: [



                    ]
                )
            )
        )
    );
  }

  /*
   * Start - Login
   */
  void authenticationProcess() {

  }
  /*
   * end - Login
   */

  /*
   * Start - Request Notification Permission for iOS
   */
  void requestNotificationPermission() async {

    if (Platform.isIOS) {

      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

      NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint("Notification Permission: ${notificationSettings.authorizationStatus}");

    }

  }
  /*
   * End - Request Notification Permission for iOS
   */

  /*
   * Start - Firebase Message Interaction
   */
  Future<void> setupInteractedMessage() async {

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {

      _handleMessage(initialMessage);

    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

  }

  void _handleMessage(RemoteMessage remoteMessage) {

    if (remoteMessage.data['messageUrl'] == 'candlestickHistory') {



    }

  }
  /*
   * End - Firebase Message Interaction
   */

}