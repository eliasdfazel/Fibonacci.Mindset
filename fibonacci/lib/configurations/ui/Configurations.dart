/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/22/24, 12:43 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fibonacci/configurations/ui/sections/Alarms.dart';
import 'package:fibonacci/configurations/ui/sections/ConfigurationsBottomBar.dart';
import 'package:fibonacci/configurations/ui/sections/elements/Choices.dart';
import 'package:fibonacci/configurations/utils/query_helper.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/rhythms/database/RhythmsDataStructure.dart';
import 'package:fibonacci/utils/actions/BottomBarActions.dart';
import 'package:fibonacci/utils/modifications/Colors.dart';
import 'package:fibonacci/utils/navigations/NavigationCommands.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfigurationsInterface extends StatefulWidget {

  RhythmDataStructure? rhythmDataStructure;

  ConfigurationsInterface({Key? key, required this.rhythmDataStructure}) : super(key: key);

  @override
  State<ConfigurationsInterface> createState() => _ConfigurationsInterfaceState();
}
class _ConfigurationsInterfaceState extends State<ConfigurationsInterface> implements BottomBarActions {

  Widget categoriesPlaceholder = Container();
  Widget colorsTagsPlaceholder = Container();

  TextEditingController titleController = TextEditingController();
  Color titleWarning = ColorsResources.premiumLight;

  TextEditingController descriptionController = TextEditingController();
  Color descriptionWarning = ColorsResources.premiumLight;

  TextEditingController locationController = TextEditingController();
  Color locationWarning = ColorsResources.premiumLight;

  String tagsSelected = "";
  Color tagsWarning = ColorsResources.premiumLight;

  String colorsSelected = "";
  Color colorsWarning = ColorsResources.premiumLight;

  List<Choices> allColorsTagsChoices = [];

  List<Choices> allCategoriesChoices = [];

  AlarmsInterface alarmsInterface = AlarmsInterface();

  bool rhythmUpdated = false;

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePopWithResult(context, rhythmUpdated);

    return true;
  }

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

    retrieveAssets();

  }

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
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
                        child: setupContentWrapper()
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
                              child: ConfigurationsBottomBarInterface(bottomBarActions: this)
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

  }

  @override
  void leftAction() {

    navigatePopWithResult(context, rhythmUpdated);

  }

  @override
  void rightAction() {

  }

  Widget setupContentWrapper() {

    return ListView(
        padding: const EdgeInsets.only(top: 73, bottom: 103),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [

          textOptionsWidget(StringsResources.titleTitle(),
              StringsResources.titleHint(),
              titleController,
              titleWarning),

          const Divider(
              height: 13,
              color: Colors.transparent
          ),

          textOptionsWidget(StringsResources.descriptionTitle(),
              StringsResources.descriptionHint(),
              descriptionController,
              descriptionWarning),

          const Divider(
              height: 13,
              color: Colors.transparent
          ),

          textOptionsWidget(StringsResources.locationTitle(),
              StringsResources.locationHint(),
              locationController,
              locationWarning),

          const Divider(
              height: 37,
              color: Colors.transparent
          ),

          categoriesPlaceholder,

          const Divider(
              height: 13,
              color: Colors.transparent
          ),

          colorsTagsPlaceholder,

          const Divider(
              height: 37,
              color: Colors.transparent
          ),

          alarmsInterface

        ]
    );

  }

  /*
   * Start - Assets
   */
  void retrieveAssets() async {

    /*
     * Start - Colors Tags
     */
    FirebaseFirestore.instance.doc("/Fibonacci/Mindset/Assets/Colors")
        .get().then((DocumentSnapshot documentSnapshot) async {

      List<dynamic> colorsTagsList = json.decode((documentSnapshot.data() as Map<String, dynamic>)["pastelColors"].toString());

      List<Map<String, Color>> allTagsColors = [];

      for (var element in colorsTagsList) {

        var colorTag = element as Map<String, dynamic>;

        allTagsColors.add({colorTag.keys.first: convertToColor(colorTag.values.first)});

      }

      List<Map<String, Color>> selectedTagsColors = [];

      DocumentSnapshot rhythmDocumentSnapshot = await FirebaseFirestore.instance
          .doc("/Fibonacci/Mindset/Profiles/${FirebaseAuth.instance.currentUser!.email!.toUpperCase()}/Rhythms/${widget.rhythmDataStructure!.documentId()}").get();

      if (rhythmDocumentSnapshot.exists) {



      }

      setState(() {

        colorsTagsPlaceholder = colorsTagsOptionsWidget(StringsResources.colorsTagsTitle(), allTagsColors, selectedTagsColors, colorsWarning);

      });

    });
    /*
     * End - Colors Tags
     */

    /*
     * Start - Categories
     */
    FirebaseFirestore.instance.doc("/Fibonacci/Mindset/Assets/Categories")
        .get().then((DocumentSnapshot documentSnapshot) {

      List<dynamic> colorsTagsList = json.decode((documentSnapshot.data() as Map<String, dynamic>)["tags"].toString());

      List<Map<String, Color>> allCategories = [];

      for (var element in colorsTagsList) {

        var category = element as Map<String, dynamic>;

        allCategories.add({category.keys.first: ColorsResources.premiumDark});

      }

      List<Map<String, Color>> selectedCategories = [];

      setState(() {

        categoriesPlaceholder = categoriesOptionsWidget(StringsResources.categoriesTitle(), allCategories, selectedCategories, tagsWarning);

      });

    });
    /*
     * End - Categories
     */
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

  /// selectedChoice: CSV
  Widget categoriesOptionsWidget(String title,
      List<Map<String, Color>> inputChoices, List<Map<String, Color>> selectedChoices,
      Color warningColor) {

    for (var element in inputChoices) {

      allCategoriesChoices.add(Choices(choiceInformation: element, choiceSelected: mapContains(selectedChoices, element)));

    }

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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          border: const Border.symmetric(
                            horizontal: BorderSide(color: ColorsResources.premiumDark, width: 1),
                            vertical: BorderSide(color: ColorsResources.premiumDark, width: 5),
                          )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: ListView(
                          padding: const EdgeInsets.only(left: 19, right: 19),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: allCategoriesChoices
                        )
                      )
                  )
              )

            ]
        )
    );
  }

  Widget colorsTagsOptionsWidget(String title,
      List<Map<String, Color>> inputChoices, List<Map<String, Color>> selectedChoices,
      Color warningColor) {

    for (var element in inputChoices) {

      allColorsTagsChoices.add(Choices(choiceInformation: element, choiceSelected: mapContains(selectedChoices, element)));

    }

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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          border: const Border.symmetric(
                            horizontal: BorderSide(color: ColorsResources.premiumDark, width: 1),
                            vertical: BorderSide(color: ColorsResources.premiumDark, width: 5),
                          )
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(19),
                          child: ListView(
                              padding: const EdgeInsets.only(left: 19, right: 19),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: allColorsTagsChoices
                          )
                      )
                  )
              )

            ]
        )
    );
  }
  /*
   * End - Assets
   */

}