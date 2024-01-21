/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/21/24, 10:41 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/resources/colors_resources.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:widget_mask/widget_mask.dart';

class Choices extends StatefulWidget {

  Map<String, Color> choiceInformation;

  bool choiceSelected = false;

  Choices({Key? key, required this.choiceInformation, required this.choiceSelected}) : super(key: key);

  @override
  State<Choices> createState() => _ChoicesState();
}
class _ChoicesState extends State<Choices> {

  Color backgroundColor = Colors.transparent;

  Color borderColor = ColorsResources.premiumDark;
  Color textColor = ColorsResources.premiumLight;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.choiceSelected) {

      backgroundColor = ColorsResources.black.withOpacity(0.37);

    }

    if (widget.choiceInformation.values.first != ColorsResources.premiumDark) {

      borderColor = widget.choiceInformation.values.first;
      textColor = widget.choiceInformation.values.first;

    } else {

      borderColor = ColorsResources.premiumDark;
      textColor = ColorsResources.premiumLight;

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
          child: WidgetMask(
            blendMode: BlendMode.srcIn,
            childSaveLayer: true,
            mask: Container(
                height: 39,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    border: GradientBoxBorder(
                        gradient: LinearGradient(
                            colors: [
                              borderColor,
                              ColorsResources.black,
                              borderColor
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
                        style: TextStyle(
                            color: textColor,
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
                  border: Border.symmetric(
                    horizontal: BorderSide(color: borderColor, width: 1),
                    vertical: BorderSide(color: borderColor, width: 5),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: Text(
                        widget.choiceInformation.keys.first.toUpperCase(),
                        maxLines: 1,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 15
                        )
                      )
                  )
                )
            )
          )
        )
      ),
    );
  }

}