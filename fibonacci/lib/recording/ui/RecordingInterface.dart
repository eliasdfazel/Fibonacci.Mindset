/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:02 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:alarm/alarm.dart';
import 'package:blur/blur.dart';
import 'package:fibonacci/alarm/io/AlarmsIO.dart';
import 'package:fibonacci/alarm/utils/AlarmUtils.dart';
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/recording/ui/sections/RecordingBottomBar.dart';
import 'package:fibonacci/recording/ui/sections/RecordingTopBar.dart';
import 'package:fibonacci/reports/ui/ReportsInterface.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/actions/BarActions.dart';
import 'package:fibonacci/utils/navigations/NavigationCommands.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RecordingInterface extends StatefulWidget {

  RhythmDataStructure rhythmDataStructure;

  RecordingInterface({Key? key, required this.rhythmDataStructure}) : super(key: key);

  @override
  State<RecordingInterface> createState() => _RecordingInterfaceState();
}
class _RecordingInterfaceState extends State<RecordingInterface> implements BarActions {

  AlarmUtils alarmUtils = AlarmUtils();

  AlarmsIO alarmsIO = AlarmsIO();

  double minimumExtraTime = 1;
  double maximumExtraTime = 34;

  double extraTimeValue = 5;

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

    manageAlarm();

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

                          Blur(
                            blur: 7,
                            blurColor: ColorsResources.black,
                            colorOpacity: 0.37,
                            child: Container(),
                          ),
                          /*
                         * End - Decoration
                         */

                          /*
                           * Start - Content
                           */
                          extraTimeSlider(),

                          extraTimeChanger(),
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
                           * Start - Top Bar
                           */
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 37),
                                  child: RecordingTopBarInterface(topBarActions: this)
                              )
                          )
                          /*
                           * End - Top Bar
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

        navigateToWithFadeAnimation(context, ReportsInterface());

        break;
      }
      case BarActions.typeBottomBar: {

        manageRevertAlarm();

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

        manageRestAlarm();

        break;
      }
    }

  }

  void manageAlarm() async {
    debugPrint("Task Id: ${widget.rhythmDataStructure.taskId()}");

    await Alarm.stop(widget.rhythmDataStructure.taskId());

  }

  void manageNextAlarm() async {
    debugPrint("Task Id: ${widget.rhythmDataStructure.taskId()}");

    alarmUtils.nextAlarmProcess(widget.rhythmDataStructure, alarmsIO);

  }

  void manageRevertAlarm() async {
    debugPrint("Task Id: ${widget.rhythmDataStructure.taskId()}");

    alarmUtils.revertAlarmProcess(widget.rhythmDataStructure, alarmsIO);

  }

  void manageRestAlarm() async {
    debugPrint("Task Id: ${widget.rhythmDataStructure.taskId()}");

    alarmUtils.restAlarmProcess(widget.rhythmDataStructure, alarmsIO);

  }


  Widget extraTimeSlider() {

    return Center(
      child: SleekCircularSlider(
        min: minimumExtraTime,
        max: maximumExtraTime,
        initialValue: extraTimeValue,
        appearance: CircularSliderAppearance(
          size: 301,
          animDurationMultiplier: 0.37,
          animationEnabled: true,
          customWidths: CustomSliderWidths(
            handlerSize: 11,
            progressBarWidth: 21,
            trackWidth: 21,
            shadowWidth: 73
          ),
          customColors: CustomSliderColors(
            dynamicGradient: true,
            trackColor: ColorsResources.premiumDark.withOpacity(0.19),
            dotColor: ColorsResources.premiumLight.withOpacity(0.19),
            shadowColor: ColorsResources.blue,
            shadowMaxOpacity: 0.01,
            progressBarColors: [
              ColorsResources.blue,
              ColorsResources.blueGreen,
              ColorsResources.darkPurple,
            ]
          ),
          infoProperties: InfoProperties()
        ),
        onChangeEnd: (double endValue) {

          setState(() {

            extraTimeValue = endValue;

          });

        },
        innerWidget: (double value) {

          return Center(
            child: Text(
              value.round().toString(),
              maxLines: 1,
              style: TextStyle(
                color: ColorsResources.premiumLight,
                fontSize: 31,
                shadows: [
                  Shadow(
                    color: ColorsResources.white.withOpacity(0.37),
                    blurRadius: 19,
                    offset: const Offset(0.0, 3.0)
                  )
                ]
              )
            )
          );
        },
      )
    );
  }

  Widget extraTimeChanger() {

    return Center(
      child: Padding(
          padding: const EdgeInsets.only(left: 37, right: 37, top: 273),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                /*
             * Start - Decrease
             */
                InkWell(
                    onTap: () {

                      setState(() {

                        if (extraTimeValue > minimumExtraTime){

                          extraTimeValue -= 1;

                        }

                      });

                    },
                    child: const SizedBox(
                        height: 51,
                        width: 51,
                        child: Image(
                          image: AssetImage("assets/decrease.png"),
                        )
                    )
                ),
                /*
             * End - Decrease
             */

                /*
             * Start - Increase
             */
                InkWell(
                    onTap: () {

                      setState(() {

                        if (extraTimeValue < maximumExtraTime){

                          extraTimeValue += 1;

                        }

                      });

                    },
                    child: const SizedBox(
                        height: 51,
                        width: 51,
                        child: Image(
                          image: AssetImage("assets/increase.png"),
                        )
                    )
                ),
                /*
             * End - Increase
             */

              ]
          )
      )
    );
  }

}