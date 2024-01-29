/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:02 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/utils/actions/BarActions.dart';
import 'package:flutter/material.dart';

class RecordingTopBarInterface extends StatefulWidget {

  BarActions topBarActions;

  RecordingTopBarInterface({Key? key, required this.topBarActions}) : super(key: key);

  @override
  State<RecordingTopBarInterface> createState() => _RecordingTopBarInterfaceState();
}
class _RecordingTopBarInterfaceState extends State<RecordingTopBarInterface> {

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.only(left: 31, right: 31),
        child: SizedBox(
          height: 111,
          width: double.infinity,
          child: Stack(
              children: [

                /*
                * Start - Background
                */
                Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                      children: [


                        Blur(
                          blur: 3,
                          blurColor: ColorsResources.premiumDark,
                          colorOpacity: 0.37,
                          borderRadius: BorderRadius.circular(31),
                          child: const SizedBox(
                            height: 73,
                            width: 356,
                          ),
                        ),


                        const SizedBox(
                            height: 73,
                            width: 356,
                            child: Image(
                              image: AssetImage("assets/bar_background.png"),
                            )
                        )
                      ]
                  ),
                ),

                /*
                * End - Background
                */

                /*
                * Start - Revert
                */
                Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        height: 73,
                        width: 73,
                        child: InkWell(
                            onTap: () async {

                              widget.topBarActions.leftAction(barType: BarActions.typeTopBar);

                            },
                            child: const Image(
                                image: AssetImage("assets/reports.png")
                            )
                        )
                    )
                ),
                /*
                * End - Revert
                */

                /*
                * Start - Next
                */
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            boxShadow: [
                              BoxShadow(
                                  color: ColorsResources.black.withOpacity(0.19),
                                  blurRadius: 13,
                                  offset: const Offset(0.0, 0.0)
                              )
                            ]
                        ),
                        child: SizedBox(
                            height: 111,
                            width: 111,
                            child: InkWell(
                                onTap: () async {

                                  widget.topBarActions.centerAction(barType: BarActions.typeTopBar);

                                },
                                child: const Image(
                                  image: AssetImage("assets/end.png"),
                                )
                            )
                        )
                    )
                ),
                /*
                * End - Next
                */

                /*
                * Start - Rest
                */
                Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                        height: 73,
                        width: 73,
                        child: InkWell(
                            onTap: () async {

                              widget.topBarActions.rightAction(barType: BarActions.typeTopBar);

                            },
                            child: const Image(
                              image: AssetImage("assets/open.png"),
                            )
                        )
                    )
                ),
                /*
                * End - Rest
                */

              ]
          ),
        )
    );
  }

}