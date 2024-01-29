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
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/actions/BarActions.dart';
import 'package:fibonacci/utils/navigations/NavigationCommands.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class ReportsInterface extends StatefulWidget {

  ReportsInterface({Key? key}) : super(key: key);

  @override
  State<ReportsInterface> createState() => _ReportsInterfaceState();
}
class _ReportsInterfaceState extends State<ReportsInterface> implements BarActions {

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

                        ]
                    )
                )
            )
        )
    );
  }

  @override
  void centerAction({int barType = BarActions.typeBottomBar}) {

    switch (barType) {
      case BarActions.typeTopBar: {

        navigatePop(context);

        break;
      }
      case BarActions.typeBottomBar: {

        manageNextAlarm();

        break;
      }
    }

  }

  @override
  void leftAction({int barType = BarActions.typeBottomBar}) {

    switch (barType) {
      case BarActions.typeTopBar: {



        break;
      }
      case BarActions.typeBottomBar: {



        break;
      }
    }

  }

  @override
  void rightAction({int barType = BarActions.typeBottomBar}) {

    switch (barType) {
      case BarActions.typeTopBar: {

        Phoenix.rebirth(context);

        break;
      }
      case BarActions.typeBottomBar: {



        break;
      }
    }

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