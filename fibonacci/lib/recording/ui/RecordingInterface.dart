/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:02 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/alarm/utils/AlarmUtils.dart';
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/recording/ui/sections/RecordingBottomBar.dart';
import 'package:fibonacci/recording/ui/sections/RecordingTopBar.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/actions/BarActions.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:flutter/material.dart';

class RecordingInterface extends StatefulWidget {

  RhythmDataStructure? rhythmDataStructure;

  RecordingInterface({Key? key, required this.rhythmDataStructure}) : super(key: key);

  @override
  State<RecordingInterface> createState() => _RecordingInterfaceState();
}
class _RecordingInterfaceState extends State<RecordingInterface> implements BarActions {

  AlarmUtils alarmUtils = AlarmUtils();

  PreferencesIO preferencesIO = PreferencesIO();

  int alarmIndex = 0;

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

    manageCurrentAlarm();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringsResources.applicationName(),
        color: ColorsResources.primaryColor,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor)
        ),
        home: SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorsResources.premiumDark,
                body: ClipRRect(
                    borderRadius: BorderRadius.circular(19),
                    child: Stack(
                        children: [

                          /*
                         * Start - Decoration
                         */
                          Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/decoration.png"),
                                      fit: BoxFit.cover
                                  )
                              )
                          ),

                          const Align(
                              alignment: Alignment.centerRight,
                              child: Opacity(
                                  opacity: 0.73,
                                  child: Image(
                                    image: AssetImage("assets/logo.png"),
                                    fit: BoxFit.cover,
                                  )
                              )
                          ),
                          /*
                         * End - Decoration
                         */

                          /*
                           * Start - Content
                           */

                          /*
                           * End - Content
                           */

                          /*
                           * Start - Bottom Bar
                           */
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                  padding: const EdgeInsets.only(bottom: 37),
                                  child: RecordingBottomBarInterface(bottomBarActions: this)
                              )
                          ),
                          /*
                           * End - Bottom Bar
                           */

                          /*
                           * Start - Bottom Bar
                           */
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 37),
                                  child: RecordingTopBarInterface(topBarActions: this)
                              )
                          )
                          /*
                           * End - Bottom Bar
                           */

                        ]
                    )
                )
            )
        )
    );
  }

  @override
  void centerAction() {

  }

  @override
  void leftAction() {

  }

  @override
  void rightAction() {

  }

  void manageCurrentAlarm() async {
    // debugPrint("Task Id: ${widget.rhythmDataStructure.taskId()}");
    //
    // alarmIndex = await preferencesIO.retrieveAlarmIndex();
    //
    // await Alarm.stop(widget.rhythmDataStructure.taskId());

  }

  /// Click On Next Button
  void manageNextAlarm() async {

    // await preferencesIO.storeAlarmIndex(alarmIndex + 1);
    //
    // alarmUtils.setupAlarm(widget.rhythmDataStructure, alarmIndex + 1, preferencesIO);

  }

}