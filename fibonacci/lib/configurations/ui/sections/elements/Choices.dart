/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/21/24, 9:58 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/resources/colors_resources.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:widget_mask/widget_mask.dart';

class Choices extends StatefulWidget {

  String choiceInformation;

  bool choiceSelected = false;

  Choices({Key? key, required this.choiceInformation, required this.choiceSelected}) : super(key: key);

  @override
  State<Choices> createState() => _ChoicesState();
}
class _ChoicesState extends State<Choices> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Color backgroundColor = Colors.transparent;

    if (widget.choiceSelected) {

      backgroundColor = ColorsResources.black.withOpacity(0.37);

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
                    border: const GradientBoxBorder(
                        gradient: LinearGradient(colors: [ColorsResources.premiumDark, ColorsResources.blackTransparent, ColorsResources.premiumDark]),
                        width: 4
                    )
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: Text(
                        widget.choiceInformation,
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
                        widget.choiceInformation,
                        maxLines: 1,
                        style: const TextStyle(
                            color: ColorsResources.premiumLight,
                            fontSize: 15
                        ),
                      )
                  ),
                )
            ),
          )
        )
      ),
    );
  }

}