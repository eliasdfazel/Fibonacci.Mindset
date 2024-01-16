/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 9:53 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/rhythms/database/RhythmsDataStructure.dart';
import 'package:fibonacci/utils/modifications/colors.dart';
import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

class CategoryItemInterface extends StatefulWidget {

  RhythmDataStructure rhythmDataStructure;

  CategoryItemInterface({Key? key, required this.rhythmDataStructure}) : super(key: key);

  @override
  State<CategoryItemInterface> createState() => _CategoryItemInterfaceState();
}
class _CategoryItemInterfaceState extends State<CategoryItemInterface> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: 137,
        width: 137,
        child: Stack(
          children: [

            /*
             * Start - Background
             */
            WidgetMask(
              blendMode: BlendMode.srcATop,
              childSaveLayer: true,
              mask: ColoredBox(
                color: convertToColor(widget.rhythmDataStructure.taskColorTag()),
              ),
              child: const Image(
                image: AssetImage("assets/squircle_shape.png"),
              ),
            ),

            const Image(
              image: AssetImage("assets/squircle_adjustment_gradient.png"),
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
                height: 35,
                child: Text(
                  widget.rhythmDataStructure.taskTitle(),
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
                          splashColor: convertToColor(widget.rhythmDataStructure.taskColorTag()).withOpacity(0.73),
                          splashFactory: InkRipple.splashFactory,
                      onTap: () async {



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
    );
  }

}