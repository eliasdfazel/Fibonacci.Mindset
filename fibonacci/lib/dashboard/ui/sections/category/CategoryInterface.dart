/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 1:15 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/configurations/utils/CategorizedBy.dart';
import 'package:fibonacci/dashboard/ui/sections/category/CategoryItem.dart';
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/utils/modifications/Colors.dart';
import 'package:fibonacci/utils/modifications/Strings.dart';
import 'package:flutter/material.dart';

class CategoryInterface extends StatefulWidget {

  List<RhythmDataStructure> rhythmsDataStructures = [];

  String? searchQuery;

  int categorizedBy = 0;

  CategoryInterface({Key? key, required this.rhythmsDataStructures, required this.searchQuery, required this.categorizedBy}) : super(key: key);

  @override
  State<CategoryInterface> createState() => _CategoryInterfaceState();
}
class _CategoryInterfaceState extends State<CategoryInterface> {

  Widget rhythmsPlaceholder = Container();

  PreferencesIO preferencesIO = PreferencesIO();

  String categoryName = "...";
  Color colorTag = Colors.transparent;

  @override
  void initState() {
    super.initState();

    processTasks(widget.rhythmsDataStructures);

    debugPrint("Rhythms: ${widget.rhythmsDataStructures.length}");
  }

  @override
  Widget build(BuildContext context) {

    switch (widget.categorizedBy) {
      case CategorizedBy.categories: {

        List categoryNameMap = widget.rhythmsDataStructures.first.taskCategories().split(",");
        categoryName = convertToMapDynamic(convertToJsonDynamic(categoryNameMap.first)).keys.first;

        break;
      }
      case CategorizedBy.locations: {

        categoryName = widget.rhythmsDataStructures.first.taskLocation();

        break;
      }
      case CategorizedBy.colorsTags: {

        categoryName = "";

        List colorsTags = widget.rhythmsDataStructures.first.taskColorsTags().toString().split(",");
        colorTag = convertToColor(convertToMapDynamic(convertToJsonDynamic(colorsTags.first)).values.first);

        break;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 51),
      child: SizedBox(
          height: 215,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /*
                * Start - Title
                */
                Container(
                    height: 37,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 31, right: 31),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        gradient: LinearGradient(
                            colors: [
                              colorTag,
                              Colors.transparent
                            ]
                        )
                    ),
                    child: Text(
                        categoryName,
                        style: const TextStyle(
                            color: ColorsResources.premiumLight,
                            fontSize: 25,
                            letterSpacing: 1.7
                        )
                    )
                ),
                /*
                * End - Title
                */

                const Divider(
                  height: 23,
                  color: Colors.transparent,
                ),

                SizedBox(
                    height: 153,
                    child: rhythmsPlaceholder
                ),

              ]
          )
      )
    );
  }

  void processTasks(List<RhythmDataStructure> rhythmDataStructures) async {

    List<Widget> allRhythms = [];

    for (RhythmDataStructure rhythmDataStructure in rhythmDataStructures) {

      if (widget.searchQuery !=  null) {

        if (rhythmDataStructure.taskTitle().toLowerCase().contains(widget.searchQuery!.toLowerCase())
            || rhythmDataStructure.taskDescription().toLowerCase().contains(widget.searchQuery!.toLowerCase())
            || rhythmDataStructure.taskLocation().toLowerCase().contains(widget.searchQuery!.toLowerCase())) {
          debugPrint("Item Search Query: ${widget.searchQuery} - Query Found: ${rhythmDataStructure.rhythmDocumentData}");

          allRhythms.add(CategoryItemInterface(rhythmDataStructure: rhythmDataStructure));

        }

      } else {

        allRhythms.add(CategoryItemInterface(rhythmDataStructure: rhythmDataStructure));

      }

    }

    setState(() {

      rhythmsPlaceholder = ListView(
          padding: const EdgeInsets.only(left: 31, right: 31),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: allRhythms
      );

    });

  }

}