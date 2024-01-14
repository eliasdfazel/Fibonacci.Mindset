/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/14/24, 9:00 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:fibonacci/dashboard/ui/Dashboard.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/authentication/AuthenticationProcess.dart';
import 'package:fibonacci/utils/modifications/numbers.dart';
import 'package:fibonacci/utils/navigations/navigation_commands.dart';
import 'package:fibonacci/utils/ui/display.dart';
import 'package:fibonacci/utils/ui/system_bars.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class EntryConfigurations extends StatefulWidget {

  bool internetConnection = false;

  EntryConfigurations({Key? key, required this.internetConnection}) : super(key: key);

  @override
  State<EntryConfigurations> createState() => _EntryConfigurationState();
}
class _EntryConfigurationState extends State<EntryConfigurations> implements AuthenticationsCallback {

  AuthenticationsProcess authenticationsProcess = AuthenticationsProcess();

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

    authenticationsProcess.startGoogleAuthentication();

    requestNotificationPermission();

    setupInteractedMessage();

  }

  @override
  Widget build(BuildContext context) {

    if (widget.internetConnection) {



    } else {


    }

    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.applicationName(),
            color: ColorsResources.premiumDark,
            theme: ThemeData(
              fontFamily: 'Ubuntu',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.premiumDark),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              }),
            ),
            home: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorsResources.premiumDark,
                body: ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Stack(
                      children: [

                        Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/decoration.png"),
                                    fit: BoxFit.cover
                                )
                            )
                        ),

                        Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: calculatePercentage(93, displayLogicalWidth(context)),
                              width: calculatePercentage(93, displayLogicalWidth(context)),
                              child: const Image(
                                image: AssetImage("assets/logo.png"),
                                fit: BoxFit.cover,
                              )
                            )
                        ),

                      ]
                  )
                )
            )
        )
    );
  }

  @override
  void authenticationWithGoogleCompleted() {

    navigateToWithPop(context, DashboardInterface(internetConnection: widget.internetConnection));

  }

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