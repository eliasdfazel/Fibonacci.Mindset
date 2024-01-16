/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 12:45 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fibonacci/dashboard/ui/sections/BottomBar.dart';
import 'package:fibonacci/dashboard/ui/sections/category/Category.dart';
import 'package:fibonacci/dashboard/utils/CategorizedBy.dart';
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/rhythms/database/RhythmsDataStructure.dart';
import 'package:fibonacci/rhythms/database/RhythmsDirectory.dart';
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
class _DashboardInterfaceState extends State<DashboardInterface> {

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

      tasksPlaceholder = waiting(StringsResources.noInternetConnection());

    }

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.applicationName(),
            color: ColorsResources.premiumDark,
            theme: ThemeData(
              fontFamily: 'Ubuntu',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.premiumDark),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              }),
            ),
            home: Scaffold(
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
                            padding: const EdgeInsets.only(left: 31, right: 31, bottom: 57),
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
                              child: BottomBarInterface()
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

  void retrieveTasks() async {

    String categorizedBy = RhythmDataStructure.taskCategoryName;

    switch (await preferencesIO.retrieveCategorizedBy()) {
      case CategorizedBy.categories: {

        categorizedBy = RhythmDataStructure.taskCategoryName;

        break;
      }
      case CategorizedBy.locations: {

        categorizedBy = RhythmDataStructure.taskLocationName;

        break;
      }
      case CategorizedBy.colorsTags: {

        categorizedBy = RhythmDataStructure.taskColorTagName;

        break;
      }
    }

    FirebaseFirestore.instance
      .collection(rhythmsCollectionsPath(FirebaseAuth.instance.currentUser!.email!))
      .orderBy(categorizedBy)
      .get().then((QuerySnapshot querySnapshot) => {

        if (querySnapshot.size > 0) {

          categorizeTasks(querySnapshot)

        }

      });

  }

  void categorizeTasks(QuerySnapshot querySnapshot) async {

    Map<String, List<RhythmDataStructure>> allRhythmsWidget = <String, List<RhythmDataStructure>>{};

    for (int i = 0; i < querySnapshot.docs.length; i++) {

      RhythmDataStructure rhythmDataStructure = RhythmDataStructure(querySnapshot.docs[i]);
      debugPrint("$i ${rhythmDataStructure.rhythmDocumentData}");

      (allRhythmsWidget[rhythmDataStructure.taskCategory()] ??= []).add(rhythmDataStructure);

    }

    List<Widget> categorizedRhythms = [];

    allRhythmsWidget.keys.forEach((element) {
      debugPrint("$element");

      categorizedRhythms.add(CategoryInterface(rhythmDataStructure: allRhythmsWidget[element]!));

    });

    setState(() {

      tasksPlaceholder = ListView(
          padding: const EdgeInsets.only(top: 53, bottom: 137),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: categorizedRhythms
      );

    });

  }

  Widget waiting([String waitingNotice = "Click On ADD \nTo Configure A Task"]) {

    return Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              LoadingAnimationWidget.threeRotatingDots(
                color: ColorsResources.premiumLight,
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