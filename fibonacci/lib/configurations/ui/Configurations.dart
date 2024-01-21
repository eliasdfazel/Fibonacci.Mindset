/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/21/24, 7:56 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:fibonacci/configurations/ui/sections/ConfigurationsBottomBar.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/rhythms/database/RhythmsDataStructure.dart';
import 'package:fibonacci/utils/modifications/Numbers.dart';
import 'package:fibonacci/utils/ui/Display.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:flutter/material.dart';

class ConfigurationsInterface extends StatefulWidget {

  ConfigurationsInterface({Key? key, RhythmDataStructure? rhythmDataStructure}) : super(key: key);

  @override
  State<ConfigurationsInterface> createState() => _ConfigurationsInterfaceState();
}
class _ConfigurationsInterfaceState extends State<ConfigurationsInterface> {

  Widget tasksPlaceholder = Container();

  TextEditingController titleController = TextEditingController();
  String titleWarning = "";

  TextEditingController descriptionController = TextEditingController();
  String descriptionWarning = "";

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
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

                      const Blur(
                          blur: 13.0,
                          colorOpacity: 0,
                          blurColor: Colors.transparent,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Opacity(
                                  opacity: 0.73,
                                  child: Image(
                                    image: AssetImage("assets/decoration_start.png"),
                                    fit: BoxFit.cover,
                                  )
                              )
                          )
                      ),
                      /*
                       * End - Decoration
                       */

                      /*
                       * Start - Options
                       */
                      Padding(
                        padding: const EdgeInsets.only(bottom: 73),
                        child: ListView(
                            padding: const EdgeInsets.only(top: 73),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: [

                              optionsWidget(StringsResources.titleTitle(),
                                  StringsResources.titleHint(),
                                  titleWarning,
                                  titleController),

                              const Divider(
                                height: 13,
                                color: Colors.transparent
                              ),

                              optionsWidget(StringsResources.descriptionTitle(),
                                  StringsResources.descriptionHint(),
                                  descriptionWarning,
                                  descriptionController),

                            ]
                        ),
                      ),
                      /*
                       * End - Options
                       */

                      /*
                       * Start - Bottom Bar
                       */
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 37),
                              child: ConfigurationsBottomBarInterface()
                          )
                      )
                      /*
                       * End - Bottom Bar
                       */

                    ]
                )
            )
        )
    );
  }

  Widget optionsWidget(String title, String hint, String warning, TextEditingController titleController) {

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
                          width: calculatePercentage(37, displayLogicalWidth(context)),
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
                                  style: const TextStyle(
                                      color: ColorsResources.premiumLight,
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
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorWidth: 3,
                        cursorHeight: 31,
                        cursorRadius: const Radius.circular(19),
                        style: const TextStyle(
                          color: ColorsResources.premiumLight,
                          fontSize: 21,
                          letterSpacing: 1.7
                        ),
                        decoration: InputDecoration(
                            hintText: hint,
                            errorText: warning,
                            contentPadding: const EdgeInsets.fromLTRB(13, 7, 13, 7),
                            hintStyle: const TextStyle(
                              color: ColorsResources.premiumLight,
                              fontSize: 21
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: ColorsResources.blueGrayLight, width: 0.0),
                                gapPadding: 5
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                gapPadding: 5
                            ),

                        )
                      )
                  )
              )

            ]
        )
    );
  }

}