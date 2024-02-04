/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 12:08 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/modifications/Strings.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:widget_mask/widget_mask.dart';

abstract class AlarmsActions {
  void alarmAdded() async {

  }
}

class AlarmsInterface extends StatefulWidget {

  AlarmsActions alarmsActions;

  dynamic alarmsJson;

  AlarmsInterface({Key? key, required this.alarmsActions, this.alarmsJson}) : super(key: key);

  List<Widget> alarmsInputItems = [];

  /// Each Index Represent Alarm Data
  List<TextEditingController> alarmsDurationInput = [];

  /// Each Index Represent Alarm Data
  List<TextEditingController> alarmsRepeatInput = [];

  /// Each Index Represent Alarm Data
  List<TextEditingController> alarmsRestInput = [];

  @override
  State<AlarmsInterface> createState() => _AlarmInterfaceState();
}
class _AlarmInterfaceState extends State<AlarmsInterface> {

  Widget alarmsListPlaceholder = Container();

  @override
  void initState() {
    super.initState();

    if (widget.alarmsJson != null) {

      insertCurrentAlarms(widget.alarmsJson);

    } else {

      insertAlarm();

    }

  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.only(left: 37, right: 37),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: const EdgeInsets.only(top: 13, left: 13, right: 13),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          border: const Border(
                            bottom: BorderSide(
                              color: ColorsResources.premiumDark,
                              width: 1,
                            ),
                            top: BorderSide(
                                color: ColorsResources.premiumDark,
                                width: 1
                            ),
                            left: BorderSide(
                                color: ColorsResources.premiumDark,
                                width: 5
                            ),
                            right: BorderSide(
                                color: ColorsResources.premiumDark,
                                width: 5
                            ),
                          )
                      ),
                      child: Column(
                          children: widget.alarmsInputItems
                      )
                  )
              ),

              addAlarm()

            ]
        )
    );
  }

  Widget inputAlarm(TextEditingController alarmDurationInput, TextEditingController alarmRepeatInput, TextEditingController alarmRestInput) {

    return Padding(
        padding: const EdgeInsets.only(bottom: 13),
        child: SizedBox(
            height: 39,
            width: double.infinity,
            child: Row(
                children: [

                  Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.transparent
                          ),
                          child: Stack(
                              children: [

                                WidgetMask(
                                    blendMode: BlendMode.srcIn,
                                    childSaveLayer: true,
                                    mask: Container(
                                        height: 39,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(19),
                                            border: const GradientBoxBorder(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      ColorsResources.premiumDark,
                                                      ColorsResources.black,
                                                      ColorsResources.premiumDark
                                                    ]
                                                ),
                                                width: 5
                                            )
                                        ),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 19, right: 19),
                                                child: Container()
                                            )
                                        )
                                    ),
                                    child: Container(
                                        height: 39,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(19),
                                          border: const Border.symmetric(
                                            horizontal: BorderSide(color: ColorsResources.premiumDark, width: 1),
                                            vertical: BorderSide(color: ColorsResources.premiumDark, width: 5),
                                          ),
                                        ),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 19, right: 19),
                                                child: Container()
                                            )
                                        )
                                    )
                                ),

                                Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                        controller: alarmDurationInput,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.ltr,
                                        textAlignVertical: TextAlignVertical.center,
                                        cursorColor: ColorsResources.primaryColor,
                                        autofocus: false,
                                        enableSuggestions: true,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        cursorWidth: 3,
                                        cursorHeight: 17,
                                        cursorRadius: const Radius.circular(19),
                                        style: const TextStyle(
                                            color: ColorsResources.premiumLight,
                                            fontSize: 15,
                                            letterSpacing: 1.7,
                                            height: 1.1
                                        ),
                                        decoration: InputDecoration.collapsed(
                                            hintText: StringsResources.duration(),
                                            hintStyle: TextStyle(
                                                color: ColorsResources.premiumLight.withOpacity(0.51),
                                                fontSize: 13,
                                                letterSpacing: 1.7,
                                                height: 1.1
                                            ),
                                            border: InputBorder.none
                                        )
                                    )
                                )

                              ]
                          )
                      )
                  ),

                  Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.transparent
                          ),
                          child: Stack(
                              children: [

                                WidgetMask(
                                    blendMode: BlendMode.srcIn,
                                    childSaveLayer: true,
                                    mask: Container(
                                        height: 39,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(19),
                                            border: const GradientBoxBorder(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      ColorsResources.premiumDark,
                                                      ColorsResources.black,
                                                      ColorsResources.premiumDark
                                                    ]
                                                ),
                                                width: 5
                                            )
                                        ),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 19, right: 19),
                                                child: Container()
                                            )
                                        )
                                    ),
                                    child: Container(
                                        height: 39,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(19),
                                          border: const Border.symmetric(
                                            horizontal: BorderSide(color: ColorsResources.premiumDark, width: 1),
                                            vertical: BorderSide(color: ColorsResources.premiumDark, width: 5),
                                          ),
                                        ),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 19, right: 19),
                                                child: Container()
                                            )
                                        )
                                    )
                                ),

                                Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                        controller: alarmRepeatInput,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.ltr,
                                        textAlignVertical: TextAlignVertical.center,
                                        cursorColor: ColorsResources.primaryColor,
                                        autofocus: false,
                                        enableSuggestions: true,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        cursorWidth: 3,
                                        cursorHeight: 17,
                                        cursorRadius: const Radius.circular(19),
                                        style: const TextStyle(
                                            color: ColorsResources.premiumLight,
                                            fontSize: 15,
                                            letterSpacing: 1.7,
                                            height: 1.1
                                        ),
                                        decoration: InputDecoration.collapsed(
                                            hintText: StringsResources.repeat(),
                                            hintStyle: TextStyle(
                                                color: ColorsResources.premiumLight.withOpacity(0.51),
                                                fontSize: 13,
                                                letterSpacing: 1.7,
                                                height: 1.1
                                            ),
                                            border: InputBorder.none
                                        )
                                    )
                                )

                              ]
                          )
                      )
                  ),

                  Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.transparent
                          ),
                          child: Stack(
                              children: [

                                WidgetMask(
                                    blendMode: BlendMode.srcIn,
                                    childSaveLayer: true,
                                    mask: Container(
                                        height: 39,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(19),
                                            border: const GradientBoxBorder(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      ColorsResources.premiumDark,
                                                      ColorsResources.black,
                                                      ColorsResources.premiumDark
                                                    ]
                                                ),
                                                width: 5
                                            )
                                        ),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 19, right: 19),
                                                child: Container()
                                            )
                                        )
                                    ),
                                    child: Container(
                                        height: 39,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(19),
                                          border: const Border.symmetric(
                                            horizontal: BorderSide(color: ColorsResources.premiumDark, width: 1),
                                            vertical: BorderSide(color: ColorsResources.premiumDark, width: 5),
                                          ),
                                        ),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding: const EdgeInsets.only(left: 19, right: 19),
                                                child: Container()
                                            )
                                        )
                                    )
                                ),

                                Align(
                                    alignment: Alignment.center,
                                    child: TextField(
                                        controller: alarmRestInput,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.ltr,
                                        textAlignVertical: TextAlignVertical.center,
                                        cursorColor: ColorsResources.primaryColor,
                                        autofocus: false,
                                        enableSuggestions: true,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        cursorWidth: 3,
                                        cursorHeight: 17,
                                        cursorRadius: const Radius.circular(19),
                                        style: const TextStyle(
                                            color: ColorsResources.premiumLight,
                                            fontSize: 15,
                                            letterSpacing: 1.7,
                                            height: 1.1
                                        ),
                                        decoration: InputDecoration.collapsed(
                                            hintText: StringsResources.rest(),
                                            hintStyle: TextStyle(
                                                color: ColorsResources.premiumLight.withOpacity(0.51),
                                                fontSize: 13,
                                                letterSpacing: 1.7,
                                                height: 1.1
                                            ),
                                            border: InputBorder.none
                                        )
                                    )
                                )

                              ]
                          )
                      )
                  )

                ]
            )
        )
    );
  }

  /// Add (+) Button
  Widget addAlarm() {

    return SizedBox(
      height: 39,
      width: double.infinity,
      child: Align(
          alignment: Alignment.centerLeft,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: Material(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: ColorsResources.primaryColorDarker.withOpacity(0.37),
                      splashFactory: InkRipple.splashFactory,
                      onTap: () async {

                        insertAlarm();

                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.transparent
                          ),
                          child: WidgetMask(
                              blendMode: BlendMode.srcIn,
                              childSaveLayer: true,
                              mask: Container(
                                  height: 39,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(19),
                                      border: const GradientBoxBorder(
                                          gradient: LinearGradient(
                                              colors: [
                                                ColorsResources.premiumDark,
                                                ColorsResources.black,
                                                ColorsResources.premiumDark
                                              ]
                                          ),
                                          width: 5
                                      )
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 19, right: 19),
                                        child: Text(
                                          "+",
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: ColorsResources.premiumLight,
                                              fontSize: 19
                                          ),
                                        )
                                    ),
                                  )
                              ),
                              child: Container(
                                  height: 39,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19),
                                    border: const Border.symmetric(
                                      horizontal: BorderSide(color: ColorsResources.premiumDark, width: 1),
                                      vertical: BorderSide(color: ColorsResources.premiumDark, width: 5),
                                    ),
                                  ),
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 19, right: 19),
                                          child: Text(
                                              "+",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: ColorsResources.premiumLight,
                                                  fontSize: 19
                                              )
                                          )
                                      )
                                  )
                              )
                          )
                      )
                  )
              )
          )
      ),
    );
  }

  void insertAlarm() async {

    if (widget.alarmsInputItems.isNotEmpty) {

      widget.alarmsActions.alarmAdded();

    }

    TextEditingController durationController = TextEditingController();
    widget.alarmsDurationInput.add(durationController);

    TextEditingController repeatController = TextEditingController();
    widget.alarmsRepeatInput.add(repeatController);

    TextEditingController restController = TextEditingController();
    widget.alarmsRestInput.add(restController);

    widget.alarmsInputItems.add(inputAlarm(widget.alarmsDurationInput.last, widget.alarmsRepeatInput.last, widget.alarmsRestInput.last));

    setState(() {

      widget.alarmsInputItems;

    });

  }

  Future insertCurrentAlarms(dynamic alarmsJson) async {

    List listOfAlarm = List.from(convertToJsonDynamic(alarmsJson));

    for (var element in listOfAlarm) {

      TextEditingController durationController = TextEditingController();
      durationController.text = element[RhythmDataStructure.taskDuration];
      widget.alarmsDurationInput.add(durationController);

      TextEditingController repeatController = TextEditingController();
      repeatController.text = element[RhythmDataStructure.taskRepeat];
      widget.alarmsRepeatInput.add(repeatController);

      TextEditingController restController = TextEditingController();
      restController.text = element[RhythmDataStructure.taskRest];
      widget.alarmsRestInput.add(restController);

      widget.alarmsInputItems.add(inputAlarm(widget.alarmsDurationInput.last, widget.alarmsRepeatInput.last, widget.alarmsRestInput.last));

    }

    setState(() {

      widget.alarmsInputItems;

    });

  }

}

