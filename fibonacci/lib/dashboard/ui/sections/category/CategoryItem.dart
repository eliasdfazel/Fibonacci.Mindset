/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 1:15 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/configurations/ui/Configurations.dart';
import 'package:fibonacci/database/rhythms/RhythmsDataStructure.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/utils/modifications/Colors.dart';
import 'package:fibonacci/utils/modifications/Strings.dart';
import 'package:fibonacci/utils/navigations/NavigationCommands.dart';
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

    List colorsTags = widget.rhythmDataStructure.taskColorsTags().toString().split(",");

    Color itemColor = convertToColor(convertToMapDynamic(convertToJsonDynamic(colorsTags.first)).values.first);

    return Padding(
        padding: const EdgeInsets.only(right: 19),
        child: SizedBox(
            height: 137,
            width: 137,
            child: Stack(
                children: [

                  /*
                   * Start - Background
                   */
                  Center(
                      child: SizedBox(
                          height: 136,
                          width: 136,
                          child: WidgetMask(
                              blendMode: BlendMode.srcATop,
                              childSaveLayer: true,
                              mask: ColoredBox(
                                color: itemColor,
                              ),
                              child: const Image(
                                image: AssetImage("assets/squircle_shape.png"),
                                fit: BoxFit.cover,
                              )
                          )
                      )
                  ),

                  const SizedBox(
                    height: 137,
                    width: 137,
                    child: Image(
                      image: AssetImage("assets/squircle_adjustment_gradient.png"),
                      fit: BoxFit.cover,
                    ),
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
                        height: 73,
                        child: Text(
                          widget.rhythmDataStructure.taskTitle(),
                          maxLines: 3,
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
                   * Start - Ripple Adjustment
                   */
                  SizedBox(
                      height: 137,
                      width: 137,
                      child: WidgetMask(
                        blendMode: BlendMode.srcIn,
                        childSaveLayer: true,
                        mask: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: InkWell(
                                splashColor: ColorsResources.premiumDark,
                                splashFactory: InkRipple.splashFactory,
                                onTap: () async {

                                  Future.delayed(const Duration(milliseconds: 333), () {

                                    navigateToWithFadeAnimation(context, ConfigurationsInterface(rhythmDataStructure: widget.rhythmDataStructure));

                                  });

                                },
                                child: Container()
                            )
                        ),
                        child: const Image(
                            image: AssetImage("assets/squircle_adjustment_gradient.png"),
                            fit: BoxFit.cover
                        ),
                      )
                  ),
                  /*
                   * End - Ripple Adjustment
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
                                  splashColor: itemColor.withOpacity(0.73),
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () {

                                    Future.delayed(const Duration(microseconds: 333), () async {



                                    });

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
        )
    );
  }

}