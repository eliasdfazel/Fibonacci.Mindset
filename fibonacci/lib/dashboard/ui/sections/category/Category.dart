/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 9:24 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/rhythms/database/RhythmsDataStructure.dart';
import 'package:flutter/material.dart';

class CategoryInterface extends StatefulWidget {

  RhythmDataStructure rhythmDataStructure;

  CategoryInterface({Key? key, required this.rhythmDataStructure}) : super(key: key);

  @override
  State<CategoryInterface> createState() => _CategoryInterfaceState();
}
class _CategoryInterfaceState extends State<CategoryInterface> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String title = widget.rhythmDataStructure.taskTitle();
    Color colorTag = Colors.transparent;

    // if (1 == 1) {
    //
    //   title = widget.rhythmDataStructure.taskTitle();
    //
    // } else {
    //
    //   title = widget.rhythmDataStructure.taskLocation();
    //
    // } else {
    //   title = "";
    //   colorTag = convertToColor(widget.rhythmDataStructure.taskColorTag());
    //
    // }

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
                  title
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

  void processAlarmsConfigurations() async {

  }

}