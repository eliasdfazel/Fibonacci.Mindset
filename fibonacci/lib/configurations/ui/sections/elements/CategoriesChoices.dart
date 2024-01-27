/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 12:23 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/resources/colors_resources.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:widget_mask/widget_mask.dart';

class CategoriesChoices extends StatefulWidget {

  Map<String, String> choiceInformation;

  bool choiceSelected = false;

  CategoriesChoices({Key? key, required this.choiceInformation, required this.choiceSelected}) : super(key: key);

  @override
  State<CategoriesChoices> createState() => _CategoriesChoicesState();
}
class _CategoriesChoicesState extends State<CategoriesChoices> {

  Color backgroundColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.choiceSelected) {

      backgroundColor = ColorsResources.premiumDark.withOpacity(0.73);

    }

    return Container(
      height: 73,
      padding: const EdgeInsets.only(right: 19),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: backgroundColor
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: Material(
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                child: InkWell(
                    splashColor: ColorsResources.primaryColorDarker.withOpacity(0.37),
                    splashFactory: InkRipple.splashFactory,
                    onTap: () async {

                      setState(() {

                        if (widget.choiceSelected) {

                          backgroundColor = Colors.transparent;
                          widget.choiceSelected = false;

                        } else {

                          backgroundColor = ColorsResources.premiumDark.withOpacity(0.73);
                          widget.choiceSelected = true;

                        }


                      });

                    },
                    child: WidgetMask(
                        blendMode: BlendMode.srcIn,
                        childSaveLayer: true,
                        mask: Container(
                            height: 39,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(19),
                                border: const GradientBoxBorder(
                                    gradient: LinearGradient(
                                        colors: [
                                          ColorsResources.premiumDark,
                                          ColorsResources.black,
                                          ColorsResources.premiumDark
                                        ]
                                    ),
                                    width: 5
                                )
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 19, right: 19),
                                  child: Text(
                                    widget.choiceInformation.keys.first.toUpperCase(),
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: ColorsResources.premiumLight,
                                        fontSize: 15
                                    ),
                                  )
                              ),
                            )
                        ),
                        child: Container(
                            height: 39,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              border: const Border.symmetric(
                                horizontal: BorderSide(color: ColorsResources.premiumDark, width: 1),
                                vertical: BorderSide(color: ColorsResources.premiumDark, width: 5),
                              ),
                            ),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 19, right: 19),
                                    child: Text(
                                        widget.choiceInformation.keys.first.toUpperCase(),
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: ColorsResources.premiumLight,
                                            fontSize: 15
                                        )
                                    )
                                )
                            )
                        )
                    )
              )
            )
          )
        )
      )
    );
  }

}