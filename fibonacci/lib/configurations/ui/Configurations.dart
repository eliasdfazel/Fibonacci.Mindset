/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 1:15 PM
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
import 'package:fibonacci/configurations/ui/sections/elements/CategoriesChoices.dart';
import 'package:fibonacci/configurations/ui/sections/elements/ColorsChoices.dart';
import 'package:fibonacci/configurations/utils/AlarmsProcess.dart';
import 'package:fibonacci/configurations/utils/Validations.dart';
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/database/rhythms/RhythmsDirectory.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/actions/BottomBarActions.dart';
import 'package:fibonacci/utils/modifications/Strings.dart';
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
class _ConfigurationsInterfaceState extends State<ConfigurationsInterface> implements BottomBarActions, AlarmsActions {

  ScrollController contentScroll = ScrollController();

  TextEditingController titleController = TextEditingController();
  Color titleWarning = ColorsResources.premiumLight;

  TextEditingController descriptionController = TextEditingController();
  Color descriptionWarning = ColorsResources.premiumLight;

  TextEditingController locationController = TextEditingController();
  Color locationWarning = ColorsResources.premiumLight;

  List<ColorsChoices> allColorsTagsChoices = [];

  Widget colorsTagsList = Container();
  Color categoriesWarning = ColorsResources.premiumLight;

  List<CategoriesChoices> allCategoriesChoices = [];

  Widget categoriesList = Container();
  Color colorsWarning = ColorsResources.premiumLight;

  late AlarmsInterface alarmsInterface;
  Color alarmsWarning = ColorsResources.premiumLight;

  bool rhythmUpdated = false;

  String documentId = DateTime.now().millisecondsSinceEpoch.toString();

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    navigatePopWithResult(context, rhythmUpdated);

    return true;
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

    alarmsInterface = AlarmsInterface(alarmsActions: this);

    if (widget.rhythmDataStructure != null) {
      debugPrint("RhythmDataStructure: ${widget.rhythmDataStructure!.rhythmDocumentData}");

      insertCurrentRhythm(widget.rhythmDataStructure!);

    }

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

    insertProcess();

  }

  @override
  void leftAction() {

    navigatePopWithResult(context, rhythmUpdated);

  }

  @override
  void rightAction() {

  }

  @override
  void alarmAdded() {

    Future.delayed(const Duration(milliseconds: 555), () async {

      contentScroll.animateTo(contentScroll.position.maxScrollExtent, duration: const Duration(milliseconds: 333), curve: Curves.easeIn);

    });

  }

  Widget setupContentWrapper() {

    return ListView(
        padding: const EdgeInsets.only(top: 73, bottom: 103),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: contentScroll,
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

          categoriesSelector(StringsResources.categoriesTitle()),

          const Divider(
              height: 13,
              color: Colors.transparent
          ),

          colorsTagsSelector(StringsResources.colorsTagsTitle()),

          const Divider(
              height: 37,
              color: Colors.transparent
          ),

          /*
           * Start - Alarm
           */
          Padding(
              padding: const EdgeInsets.only(left: 54, right: 37),
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

          alarmsInterface
          /*
           * End - Alarm
           */

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

      List<Map<String, String>> allTagsColors = [];

      for (var element in colorsTagsList) {

        var colorTag = element as Map<String, dynamic>;

        allTagsColors.add({colorTag.keys.first: colorTag.values.first});

      }

      List<Map<String, String>> selectedTagsColors = [];

      if (widget.rhythmDataStructure != null) {

        List colorsTags = widget.rhythmDataStructure!.taskColorsTags().toString().split(",");

        for (var element in colorsTags) {

          if (element != null && element.toString().isNotEmpty) {

            Map<String, dynamic> itemColor = convertToMapDynamic(convertToJsonDynamic(element));

            selectedTagsColors.add({itemColor.keys.first: itemColor.values.first});

          }

        }

      }

      colorsTagsOptions(allTagsColors, selectedTagsColors);

    });
    /*
     * End - Colors Tags
     */

    /*
     * Start - Categories
     */
    FirebaseFirestore.instance.doc("/Fibonacci/Mindset/Assets/Categories")
        .get().then((DocumentSnapshot documentSnapshot) async {

      List<dynamic> colorsTagsList = json.decode((documentSnapshot.data() as Map<String, dynamic>)["tags"].toString());

      List<Map<String, String>> allCategories = [];

      for (var element in colorsTagsList) {

        var category = element as Map<String, dynamic>;

        allCategories.add({category.keys.first: category.values.first});

      }

      List<Map<String, String>> selectedCategories = [];

      if (widget.rhythmDataStructure != null) {

        List categories = widget.rhythmDataStructure!.taskCategories().toString().split(",");

        for (var element in categories) {

          if (element != null && element.toString().isNotEmpty) {

            Map<String, dynamic> itemCategory = convertToMapDynamic(convertToJsonDynamic(element));

            selectedCategories.add({itemCategory.keys.first: itemCategory.values.first});

          }

        }

      }

      categoriesOptions(allCategories, selectedCategories);

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
  Widget categoriesSelector(String title) {

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
                                      color: categoriesWarning,
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
                          child: categoriesList
                      )
                  )
              )

            ]
        )
    );
  }
  void categoriesOptions(List<Map<String, String>> inputChoices,
      List<Map<String, String>> selectedChoices) {

    for (var element in inputChoices) {


      allCategoriesChoices.add(CategoriesChoices(choiceInformation: element, choiceSelected: mapContains(selectedChoices, element)));

    }

    setState(() {

      categoriesList = ListView(
          padding: const EdgeInsets.only(left: 19, right: 19),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: allCategoriesChoices
      );

    });

  }

  /// selectedChoice: CSV
  Widget colorsTagsSelector(String title) {

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
                                      color: colorsWarning,
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
                          child: colorsTagsList
                      )
                  )
              )

            ]
        )
    );
  }
  void colorsTagsOptions(List<Map<String, String>> inputChoices,
      List<Map<String, String>> selectedChoices) {

    for (var element in inputChoices) {

      allColorsTagsChoices.add(ColorsChoices(choiceInformation: element, choiceSelected: mapContains(selectedChoices, element)));

    }

    setState(() {

      colorsTagsList = ListView(
          padding: const EdgeInsets.only(left: 19, right: 19),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: allColorsTagsChoices
      );

    });

  }
  /*
   * End - Assets
   */

  void insertProcess() async {

    String taskTitle = titleController.value.text;
    String taskDescription = descriptionController.value.text;
    String taskLocation = locationController.value.text;

    String taskCategories = "";
    String taskColorsTags = "";

    String taskAlarmsConfigurations = await processAlarmsToJson(alarmsInterface);

    bool validationResult = true;

    for (var element in allCategoriesChoices) {

      if (element.choiceSelected) {

        taskCategories += "${prepareMap(element.choiceInformation)},";

      }

    }

    for (var element in allColorsTagsChoices) {

      if (element.choiceSelected) {

        taskColorsTags += "${prepareMap(element.choiceInformation)},";

      }

    }

    if (taskTitle.isEmpty) {

      validationResult = false;

      setState(() {

        titleWarning = ColorsResources.red;

      });

    } else {

      setState(() {

        titleWarning = ColorsResources.premiumLight;

      });

    }

    if (taskDescription.isEmpty) {

      validationResult = false;

      setState(() {

        descriptionWarning = ColorsResources.red;

      });

    } else {

      setState(() {

        descriptionWarning = ColorsResources.premiumLight;

      });

    }

    if (taskLocation.isEmpty) {

      validationResult = false;

      setState(() {

        locationWarning = ColorsResources.red;

      });

    } else {

      setState(() {

        locationWarning = ColorsResources.premiumLight;

      });

    }

    if (taskCategories.isEmpty) {

      validationResult = false;

      setState(() {

        categoriesWarning = ColorsResources.red;

      });

    } else {

      setState(() {

        categoriesWarning = ColorsResources.premiumLight;

      });

    }

    if (taskColorsTags.isEmpty) {

      validationResult = false;

      setState(() {

        colorsWarning = ColorsResources.red;

      });

    } else {

      setState(() {

        colorsWarning = ColorsResources.premiumLight;

      });

    }

    if (taskAlarmsConfigurations.isEmpty) {

      validationResult = false;

      setState(() {

        alarmsWarning = ColorsResources.red;

      });

    } else {

      setState(() {

        alarmsWarning = ColorsResources.premiumLight;

      });

    }

    if (validationResult) {

      FirebaseFirestore.instance
          .doc(rhythmsDocumentsPath(FirebaseAuth.instance.currentUser!.email!, documentId))
          .set(
            rhythmDocument(taskTitle, taskDescription, taskLocation,
                taskCategories, taskColorsTags,
                taskAlarmsConfigurations)
          ).then((value) {

            rhythmUpdated = true;

          });

    } else {
      debugPrint("Validation Process Failed");
    }

  }

  void insertCurrentRhythm(RhythmDataStructure rhythmDataStructure) {

    titleController.text = rhythmDataStructure.taskTitle();
    descriptionController.text = rhythmDataStructure.taskDescription();
    locationController.text = rhythmDataStructure.taskLocation();

  }

}