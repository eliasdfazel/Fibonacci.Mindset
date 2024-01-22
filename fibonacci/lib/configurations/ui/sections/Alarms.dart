/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/22/24, 11:45 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:widget_mask/widget_mask.dart';

class AlarmsInterface extends StatefulWidget {

  AlarmsInterface({Key? key}) : super(key: key);

  @override
  State<AlarmsInterface> createState() => _AlarmInterfaceState();
}
class _AlarmInterfaceState extends State<AlarmsInterface> {

  Color alarmsWarning = ColorsResources.premiumLight;

  Widget alarmsListPlaceholder = Container();

  List<Widget> alarmsInputItems = [];

  /// Each Index Represent Alarm Data
  List<TextEditingController> alarmsDurationInput = [];

  /// Each Index Represent Alarm Data
  List<TextEditingController> alarmsRepeatInput = [];

  /// Each Index Represent Alarm Data
  List<TextEditingController> alarmsRestInput = [];

  @override
  void initState() {
    super.initState();

    insertAlarm();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
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
                                  StringsResources.alarmsTitle(),
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: alarmsWarning,
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
                          children: alarmsInputItems
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
                                            fontSize: 13,
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
                                            fontSize: 13,
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
                                            fontSize: 13,
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

  /// Add + Button
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

    setState(() {

      alarmsDurationInput.add(TextEditingController());
      alarmsRepeatInput.add(TextEditingController());
      alarmsRestInput.add(TextEditingController());

      alarmsInputItems.add(inputAlarm(alarmsDurationInput.last, alarmsRepeatInput.last, alarmsRestInput.last));

    });

  }

}

