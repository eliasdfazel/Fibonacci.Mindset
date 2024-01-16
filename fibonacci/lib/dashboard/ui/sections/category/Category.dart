/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 12:47 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/dashboard/utils/CategorizedBy.dart';
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/rhythms/database/RhythmsDataStructure.dart';
import 'package:fibonacci/utils/modifications/Colors.dart';
import 'package:flutter/material.dart';

class CategoryInterface extends StatefulWidget {

  List<RhythmDataStructure> rhythmDataStructure = [];

  CategoryInterface({Key? key, required this.rhythmDataStructure}) : super(key: key);

  @override
  State<CategoryInterface> createState() => _CategoryInterfaceState();
}
class _CategoryInterfaceState extends State<CategoryInterface> {

  PreferencesIO preferencesIO = PreferencesIO();

  String categoryName = "...";
  Color colorTag = Colors.transparent;

  @override
  void initState() {
    super.initState();

    processTasks();

    debugPrint("Rhythms: ${widget.rhythmDataStructure.length}");
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 37),
      child: SizedBox(
          height: 193,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /*
                * Start - Title
                */
                Container(
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
                            fontSize: 23,
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
                    height: 137,
                    child: ListView(
                        padding: const EdgeInsets.only(right: 301),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [



                        ]
                    )
                ),

              ]
          )
      )
    );
  }

  void processTasks() async {

    int categorizedBy = await preferencesIO.retrieveCategorizedBy();

    switch (categorizedBy) {
      case CategorizedBy.categories: {

        setState(() {

          categoryName = widget.rhythmDataStructure.first.taskCategory();

        });

        break;
      }
      case CategorizedBy.locations: {

        setState(() {

          categoryName = widget.rhythmDataStructure.first.taskLocation();

        });

        break;
      }
      case CategorizedBy.colorsTags: {

        setState(() {

          categoryName = "";
          colorTag = convertToColor(widget.rhythmDataStructure.first.taskColorTag());

        });

        break;
      }
    }

  }

}