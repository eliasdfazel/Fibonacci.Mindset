/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:07 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fibonacci/configurations/ui/Configurations.dart';
import 'package:fibonacci/dashboard/ui/sections/DashboardBottomBar.dart';
import 'package:fibonacci/dashboard/ui/sections/category/Category.dart';
import 'package:fibonacci/dashboard/utils/CategorizedBy.dart';
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/rhythms/database/RhythmsDataStructure.dart';
import 'package:fibonacci/rhythms/database/RhythmsDirectory.dart';
import 'package:fibonacci/utils/actions/BottomBarActions.dart';
import 'package:fibonacci/utils/navigations/NavigationCommands.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DashboardInterface extends StatefulWidget {

  bool internetConnection = false;

  DashboardInterface({Key? key, required this.internetConnection}) : super(key: key);

  @override
  State<DashboardInterface> createState() => _DashboardInterfaceState();
}
class _DashboardInterfaceState extends State<DashboardInterface> implements BottomBarActions {

  PreferencesIO preferencesIO = PreferencesIO();

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
  void centerAction() {

    navigateToWithFadeAnimation(context, ConfigurationsInterface(rhythmDataStructure: null));

  }

  @override
  void leftAction() {

  }

  @override
  void rightAction() {

  }

  void retrieveTasks() async {

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
      .get().then((QuerySnapshot querySnapshot) => {

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

  Widget waiting({String waitingNotice = "Click On ADD \nTo Configure A Task"}) {

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

}