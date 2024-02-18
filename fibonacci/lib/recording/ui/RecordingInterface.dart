/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:02 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:blur/blur.dart';
import 'package:fibonacci/alarm/io/AlarmsIO.dart';
import 'package:fibonacci/alarm/utils/AlarmUtils.dart';
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/recording/ui/sections/RecordingBottomBar.dart';
import 'package:fibonacci/recording/ui/sections/RecordingTopBar.dart';
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

  StreamSubscription<AlarmSettings>? streamSubscription;

  AlarmUtils alarmUtils = AlarmUtils();

  AlarmsIO alarmsIO = AlarmsIO();

  TextEditingController alarmNoteController = TextEditingController();

  Color alarmNoteWarning = ColorsResources.premiumLight;

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
                          Center(
                            child: ListView(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                children: [

                                  textOptionsWidget(widget.rhythmDataStructure.taskTitle(),
                                      StringsResources.alarmHint(),
                                      alarmNoteController,
                                      alarmNoteWarning),

                                  const Divider(
                                    height: 19,
                                    color: Colors.transparent,
                                  ),

                                  extraTimeSlider(),

                                ]
                            )
                          ),
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
  void centerAction({int barType = BarActions.typeBottomBar}) async {

    switch (barType) {
      case BarActions.typeTopBar: {

        await Alarm.stopAll();

        alarmUtils.setupAlarm(widget.rhythmDataStructure, extraTimeValue.toInt());

        break;
      }
      case BarActions.typeBottomBar: {

        manageNextAlarm();

        break;
      }
    }

  }

  @override
  void leftAction({int barType = BarActions.typeBottomBar}) async {

    switch (barType) {
      case BarActions.typeTopBar: {

        Phoenix.rebirth(context);

        break;
      }
      case BarActions.typeBottomBar: {

        manageRevertAlarm();

        break;
      }
    }

  }

  @override
  void rightAction({int barType = BarActions.typeBottomBar}) async {

    switch (barType) {
      case BarActions.typeTopBar: {

        navigatePop(context);

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

    return Stack(
      alignment: Alignment.center,
      children: [

        SleekCircularSlider(
          min: minimumExtraTime,
          max: maximumExtraTime,
          initialValue: extraTimeValue,
          appearance: CircularSliderAppearance(
            size: 301,
            animDurationMultiplier: 0.37,
            animationEnabled: true,
            customWidths: CustomSliderWidths(
                handlerSize: 7,
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
            infoProperties: InfoProperties(),
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
                        fontSize: 37,
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
        ),

        extraTimeChanger()

      ]
    );
  }

  Widget extraTimeChanger() {

    return Padding(
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
    );
  }

  Widget textOptionsWidget(String title, String hint,
      TextEditingController titleController, Color warningColor) {

    return Container(
        height: 103,
        padding: const EdgeInsets.only(left: 37, right: 37),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: 29,
                          width: 173,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: const Border.symmetric(
                                horizontal: BorderSide(color: ColorsResources.premiumDark, width: 1),
                                vertical: BorderSide(color: ColorsResources.premiumDark, width: 5),
                              )
                          ),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(
                                  title,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: warningColor,
                                      fontSize: 13,
                                      letterSpacing: 1.7
                                  )
                              )
                          )
                      )
                  )
              ),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: 73,
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          border: const Border.symmetric(
                            horizontal: BorderSide(color: ColorsResources.premiumDark, width: 1),
                            vertical: BorderSide(color: ColorsResources.premiumDark, width: 5),
                          )
                      ),
                      child: TextField(
                          controller: titleController,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: ColorsResources.primaryColor,
                          autofocus: false,
                          enableSuggestions: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          cursorWidth: 3,
                          cursorHeight: 23,
                          cursorRadius: const Radius.circular(19),
                          style: const TextStyle(
                              color: ColorsResources.premiumLight,
                              fontSize: 19,
                              letterSpacing: 1.7,
                              height: 1.1
                          ),
                          decoration: InputDecoration.collapsed(
                              hintText: hint,
                              hintStyle: TextStyle(
                                  color: ColorsResources.premiumLight.withOpacity(0.51),
                                  fontSize: 19,
                                  letterSpacing: 1.7,
                                  height: 1.1
                              ),
                              border: InputBorder.none
                          )
                      )
                  )
              )

            ]
        )
    );
  }

}