/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 1:15 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fibonacci/alarm/io/AlarmsIO.dart';
import 'package:fibonacci/alarm/utils/AlarmUtils.dart';
import 'package:fibonacci/configurations/ui/Configurations.dart';
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/database/rhythms/RhythmsDirectory.dart';
import 'package:fibonacci/recording/ui/RecordingInterface.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/utils/modifications/Colors.dart';
import 'package:fibonacci/utils/modifications/Strings.dart';
import 'package:fibonacci/utils/navigations/NavigationCommands.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

class CategoryItemInterface extends StatefulWidget {

  RhythmDataStructure rhythmDataStructure;

  CategoryItemInterface({Key? key, required this.rhythmDataStructure}) : super(key: key);

  @override
  State<CategoryItemInterface> createState() => _CategoryItemInterfaceState();
}
class _CategoryItemInterfaceState extends State<CategoryItemInterface> with TickerProviderStateMixin {

  AlarmsIO alarmsIO = AlarmsIO();

  AlarmUtils alarmUtils = AlarmUtils();

  StreamSubscription<AlarmSettings>? streamSubscription;

  late AnimationController fadeAnimationController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    fadeAnimationController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 777),
        reverseDuration: const Duration(milliseconds: 333),
        animationBehavior: AnimationBehavior.preserve);
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: fadeAnimationController,
        curve: Curves.easeOut
    ));

  }

  @override
  Widget build(BuildContext context) {

    List colorsTags = widget.rhythmDataStructure.taskColorsTags().toString().split(",");

    Color itemColor = convertToColor(convertToMapDynamic(convertToJsonDynamic(colorsTags.first)).values.first);

    Future.delayed(const Duration(milliseconds: 555), () {

      fadeAnimationController.forward();

    });

    return Padding(
        padding: const EdgeInsets.only(right: 19),
        child: SizedBox(
            height: 153,
            width: 153,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Stack(
                  children: [

                    /*
                   * Start - Background
                   */
                    Center(
                        child: SizedBox(
                            height: 152,
                            width: 152,
                            child: WidgetMask(
                                blendMode: BlendMode.srcATop,
                                childSaveLayer: true,
                                mask: ColoredBox(
                                  color: itemColor,
                                ),
                                child: const Image(
                                  image: AssetImage("assets/squircle_shape.png"),
                                  fit: BoxFit.cover,
                                )
                            )
                        )
                    ),

                    const SizedBox(
                      height: 153,
                      width: 153,
                      child: Image(
                        image: AssetImage("assets/squircle_adjustment_gradient.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    /*
                   * End - Background
                   */

                    /*
                   * Start - Title
                   */
                    Positioned(
                        left: 19,
                        right: 19,
                        top: 19,
                        child: SizedBox(
                          height: 73,
                          child: Text(
                            widget.rhythmDataStructure.taskTitle(),
                            maxLines: 3,
                            style: const TextStyle(
                                color: ColorsResources.premiumLight,
                                fontSize: 15,
                                letterSpacing: 1.7
                            ),
                          ),
                        )
                    ),
                    /*
                   * End - Title
                   */

                    /*
                   * Start - Ripple Adjustment
                   */
                    SizedBox(
                        height: 153,
                        width: 153,
                        child: WidgetMask(
                            blendMode: BlendMode.srcIn,
                            childSaveLayer: true,
                            mask: Material(
                                shadowColor: Colors.transparent,
                                color: Colors.transparent,
                                child: InkWell(
                                    splashColor: ColorsResources.premiumDark,
                                    splashFactory: InkRipple.splashFactory,
                                    onTap: () async {

                                      Future.delayed(const Duration(milliseconds: 333), () async {

                                        bool rhythmUpdated = await navigateToWithFadeAnimation(context, ConfigurationsInterface(rhythmDataStructure: widget.rhythmDataStructure));

                                        if (rhythmUpdated) {

                                          updateTask();

                                        }

                                      });

                                    },
                                    child: Container()
                                )
                            ),
                            child: const Image(
                                image: AssetImage("assets/squircle_adjustment_gradient.png"),
                                fit: BoxFit.cover
                            )
                        )
                    ),
                    /*
                   * End - Ripple Adjustment
                   */

                    /*
                   * Start - Run
                   */
                    Positioned(
                        left: 19,
                        right: 19,
                        bottom: 19,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Material(
                                shadowColor: Colors.transparent,
                                color: Colors.transparent,
                                child: InkWell(
                                    splashColor: itemColor.withOpacity(0.73),
                                    splashFactory: InkRipple.splashFactory,
                                    onTap: () async {

                                      await Alarm.stopAll();

                                      if (Alarm.getAlarms().isEmpty) {

                                        await alarmsIO.resetIndexes();

                                        // ??= If Left Null then Equal To
                                        streamSubscription ??= Alarm.ringStream.stream.listen(
                                                (alarmSettings) => navigateTo(context, RecordingInterface(rhythmDataStructure: widget.rhythmDataStructure))
                                        );

                                        alarmUtils.nextAlarmProcess(widget.rhythmDataStructure, alarmsIO);

                                      }

                                    },
                                    child: const Image(
                                      image: AssetImage("assets/run_item.png"),
                                    )
                                )
                            )
                        )
                    )
                    /*
                   * End - Run
                   */

                  ]
              )
            )
        )
    );
  }

  void updateTask() {
    debugPrint("Task Updated: ${widget.rhythmDataStructure.documentId()}");

    FirebaseFirestore.instance
        .doc(rhythmsDocumentsPath(FirebaseAuth.instance.currentUser!.email!, widget.rhythmDataStructure.documentId()!))
        .get().then((documentSnapshot) {

          setState(() {

            widget.rhythmDataStructure = RhythmDataStructure(documentSnapshot);

          });

        });

  }

}