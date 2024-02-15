/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:07 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:fibonacci/preferences/ui/Preferences.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/utils/actions/BarActions.dart';
import 'package:fibonacci/utils/navigations/NavigationCommands.dart';
import 'package:flutter/material.dart';

class PreferencesBottomBarInterface extends StatefulWidget {

  BarActions bottomBarActions;

  PreferencesBottomBarInterface({Key? key, required this.bottomBarActions}) : super(key: key);

  @override
  State<PreferencesBottomBarInterface> createState() => _PreferencesBottomBarInterfaceState();
}
class _PreferencesBottomBarInterfaceState extends State<PreferencesBottomBarInterface> {

  @override
  void initState() {
    super.initState();
  }

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
                * Start - Back
                */
                Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        height: 73,
                        width: 73,
                        child: InkWell(
                            onTap: () async {

                              widget.bottomBarActions.leftAction();

                            },
                            child: const Image(
                                image: AssetImage("assets/back.png")
                            )
                        )
                    )
                ),
                /*
                * End - Back
                */

                /*
                * Start - Add
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

                                  widget.bottomBarActions.centerAction();

                                },
                                child: const Image(
                                  image: AssetImage("assets/share.png"),
                                )
                            )
                        )
                    )
                ),
                /*
                * End - Add
                */

                /*
                * Start - Menu
                */
                Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                        height: 73,
                        width: 73,
                        child: InkWell(
                            onTap: () async {

                              navigateToWithFadeAnimation(context, PreferencesInterface());

                            },
                            child: const Image(
                              image: AssetImage("assets/rate.png"),
                            )
                        )
                    )
                ),
                /*
                * End - Menu
                */

              ]
          ),
        )
    );
  }

}