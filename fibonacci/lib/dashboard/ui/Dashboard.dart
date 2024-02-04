/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 1:15 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fibonacci/configurations/ui/Configurations.dart';
import 'package:fibonacci/dashboard/ui/sections/DashboardBottomBar.dart';
import 'package:fibonacci/dashboard/ui/sections/category/CategoryInterface.dart';
import 'package:fibonacci/dashboard/utils/CategorizedBy.dart';
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/database/rhythms/RhythmsDirectory.dart';
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/actions/BarActions.dart';
import 'package:fibonacci/utils/navigations/NavigationCommands.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DashboardInterface extends StatefulWidget {

  bool internetConnection = false;

  DashboardInterface({Key? key, required this.internetConnection}) : super(key: key);

  @override
  State<DashboardInterface> createState() => _DashboardInterfaceState();
}
class _DashboardInterfaceState extends State<DashboardInterface> implements BarActions {

  PreferencesIO preferencesIO = PreferencesIO();

  TextEditingController searchQueryController = TextEditingController();
  Color searchQueryWarning = ColorsResources.premiumLight;

  Widget tasksPlaceholder = Container();

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

    if (widget.internetConnection) {

      retrieveTasks();

      tasksPlaceholder = waiting();

    } else {

      tasksPlaceholder = waiting(waitingNotice: StringsResources.noInternetConnection());

    }

    requestNotificationPermission();

    setupInteractedMessage();

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
                              alignment: Alignment.centerRight,
                              child: Opacity(
                                  opacity: 0.73,
                                  child: Image(
                                    image: AssetImage("assets/decoration_end.png"),
                                    fit: BoxFit.cover,
                                  )
                              )
                          )
                      ),
                      /*
                         * End - Decoration
                         */

                      /*
                       * Start - Task
                       */
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 57),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(31),
                                  child: SizedBox(
                                      width: double.infinity,
                                      child: tasksPlaceholder
                                  )
                              )
                          )
                      ),
                      /*
                       * End - Task
                       */

                      /*
                         * Start - Bottom Bar
                         */
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 37),
                              child: DashboardBottomBarInterface(bottomBarActions: this)
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

  @override
  void centerAction({int barType = BarActions.typeBottomBar}) async {

    bool rhythmUpdated = await navigateToWithFadeAnimation(context, ConfigurationsInterface(rhythmDataStructure: null));

    if (rhythmUpdated) {

      retrieveTasks();

    }

  }

  @override
  void leftAction({int barType = BarActions.typeBottomBar}) {

  }

  @override
  void rightAction({int barType = BarActions.typeBottomBar}) {

  }

  void retrieveTasks({Source getOptionSource = Source.server}) async {

    int categoryPreferences = await preferencesIO.retrieveCategorizedBy();

    String categorizedBy = RhythmDataStructure.taskCategoriesName;

    switch (categoryPreferences) {
      case CategorizedBy.categories: {

        categorizedBy = RhythmDataStructure.taskCategoriesName;

        break;
      }
      case CategorizedBy.locations: {

        categorizedBy = RhythmDataStructure.taskLocationName;

        break;
      }
      case CategorizedBy.colorsTags: {

        categorizedBy = RhythmDataStructure.taskColorsTagsName;

        break;
      }
    }

    FirebaseFirestore.instance
      .collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!))
      .orderBy(categorizedBy)
      .get(GetOptions(source: getOptionSource)).then((QuerySnapshot querySnapshot) => {

        if (querySnapshot.size > 0) {

          categorizeTasks(querySnapshot, categoryPreferences)

        }

      });

  }

  void categorizeTasks(QuerySnapshot querySnapshot, int categorizedBy) async {

    Map<String, List<RhythmDataStructure>> allRhythmsWidget = <String, List<RhythmDataStructure>>{};

    for (int i = 0; i < querySnapshot.docs.length; i++) {

      RhythmDataStructure rhythmDataStructure = RhythmDataStructure(querySnapshot.docs[i]);
      debugPrint("$i ${rhythmDataStructure.rhythmDocumentData}");


      switch (categorizedBy) {
        case CategorizedBy.categories: {

          (allRhythmsWidget[rhythmDataStructure.taskCategories()] ??= []).add(rhythmDataStructure);

          break;
        }
        case CategorizedBy.locations: {

          (allRhythmsWidget[rhythmDataStructure.taskLocation()] ??= []).add(rhythmDataStructure);

          break;
        }
        case CategorizedBy.colorsTags: {

          (allRhythmsWidget[rhythmDataStructure.taskColorsTags()] ??= []).add(rhythmDataStructure);

          break;
        }
      }
    }

    List<Widget> categorizedRhythms = [];

    categorizedRhythms.add(searchWidget(querySnapshot, categorizedBy));

    categorizedRhythms.add(const Divider(height: 73, color: Colors.transparent));

    for (var element in allRhythmsWidget.keys) {
      debugPrint(element);

      categorizedRhythms.add(CategoryInterface(rhythmsDataStructures: allRhythmsWidget[element]!, categorizedBy: categorizedBy));

    }

    setState(() {

      tasksPlaceholder = ListView(
          padding: const EdgeInsets.only(top: 53, bottom: 73),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: categorizedRhythms
      );

    });

  }

  /*
   * Start - Search
   */
  Widget searchWidget(QuerySnapshot querySnapshot, int categorizedBy) {

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
                                  StringsResources.searchTitle(),
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: searchQueryWarning,
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
                          controller: searchQueryController,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: ColorsResources.primaryColor,
                          autofocus: false,
                          enableSuggestions: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          cursorWidth: 3,
                          cursorHeight: 23,
                          onSubmitted: (searchQuery) async {

                            startSearchQuery(querySnapshot, searchQuery, categorizedBy);

                          },
                          onChanged: (searchQuery) {

                            if (searchQuery.isEmpty) {

                              retrieveTasks(getOptionSource: Source.cache);

                            }

                          },
                          cursorRadius: const Radius.circular(19),
                          style: const TextStyle(
                              color: ColorsResources.premiumLight,
                              fontSize: 19,
                              letterSpacing: 1.7,
                              height: 1.1
                          ),
                          decoration: InputDecoration.collapsed(
                              hintText: StringsResources.searchHint(),
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

  Future startSearchQuery(QuerySnapshot querySnapshot, String searchQuery, int categorizedBy) async {

    Map<String, List<RhythmDataStructure>> allRhythmsWidget = <String, List<RhythmDataStructure>>{};

    for (int i = 0; i < querySnapshot.docs.length; i++) {

      RhythmDataStructure rhythmDataStructure = RhythmDataStructure(querySnapshot.docs[i]);
      debugPrint("$i ${rhythmDataStructure.rhythmDocumentData}");


      switch (categorizedBy) {
        case CategorizedBy.categories: {

          (allRhythmsWidget[rhythmDataStructure.taskCategories()] ??= []).add(rhythmDataStructure);

          break;
        }
        case CategorizedBy.locations: {

          (allRhythmsWidget[rhythmDataStructure.taskLocation()] ??= []).add(rhythmDataStructure);

          break;
        }
        case CategorizedBy.colorsTags: {

          (allRhythmsWidget[rhythmDataStructure.taskColorsTags()] ??= []).add(rhythmDataStructure);

          break;
        }
      }
    }

    List<Widget> categorizedRhythms = [];

    categorizedRhythms.add(searchWidget(querySnapshot, categorizedBy));

    categorizedRhythms.add(const Divider(height: 73, color: Colors.transparent));

    for (var element in allRhythmsWidget.keys) {
      debugPrint(element);

      RhythmDataStructure rhythmDataStructure = allRhythmsWidget[element]!.first;

      if (rhythmDataStructure.taskTitle().contains(searchQuery)
        || rhythmDataStructure.taskDescription().contains(searchQuery)
        || rhythmDataStructure.taskLocation().contains(searchQuery)) {

        categorizedRhythms.add(CategoryInterface(rhythmsDataStructures: allRhythmsWidget[element]!, categorizedBy: categorizedBy));

      }

    }

    setState(() {

      tasksPlaceholder = ListView(
          padding: const EdgeInsets.only(top: 53, bottom: 73),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: categorizedRhythms
      );

    });

  }
  /*
   * End - Search
   */

  Widget waiting({String waitingNotice = "Click On ADD\nTo Configure A Task"}) {

    return Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              LoadingAnimationWidget.threeRotatingDots(
                color: ColorsResources.premiumLightTransparent,
                size: 73,
              ),

              Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 19, right: 19, top: 19),
                      child: Text(
                        waitingNotice,
                        style: const TextStyle(
                            fontSize: 19,
                            color: ColorsResources.premiumLightTransparent
                        ),
                      )
                  )
              )

            ]
        )
    );
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



  }
  /*
   * End - Firebase Message Interaction
   */


}