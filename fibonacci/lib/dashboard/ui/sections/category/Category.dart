/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 10:37 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/dashboard/utils/CategorizedBy.dart';
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/rhythms/database/RhythmsDataStructure.dart';
import 'package:flutter/material.dart';

class CategoryInterface extends StatefulWidget {

  List<RhythmDataStructure> rhythmDataStructure;

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
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: 189,
        width: double.infinity,
        child: Column(
          children: [

            /*
             * Start - Title
             */
            Container(
              height: 27,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorTag,
                    Colors.transparent
                  ]
                )
              ),
              child: Text(
                  categoryName
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
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  children: [



                  ]
                )
            ),

          ]
        )
    );
  }

  void processTasks() async {

    String categoryName = widget.rhythmDataStructure[0].taskCategory();
    Color colorTag = Colors.transparent;

    int categorizedBy = await preferencesIO.retrieveCategorizedBy();

    switch (categorizedBy) {
      case CategorizedBy.categories: {

        break;
      }
      case CategorizedBy.colorsTags: {

        break;
      }
      case CategorizedBy.locations: {

        break;
      }
    }

  }

}