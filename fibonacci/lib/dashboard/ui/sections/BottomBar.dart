/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 11:56 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/utils/test/Prototype.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

class BottomBarInterface extends StatefulWidget {

  BottomBarInterface({Key? key}) : super(key: key);

  @override
  State<BottomBarInterface> createState() => _BottomBarInterfaceState();
}
class _BottomBarInterfaceState extends State<BottomBarInterface> {

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
                * Start - Profile
                */
                Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        height: 73,
                        width: 73,
                        child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/squircle_background_gradient.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: InkWell(
                                    onTap: () async {

                                    },
                                    child: WidgetMask(
                                        blendMode: BlendMode.srcATop,
                                        childSaveLayer: true,
                                        mask: Image.network(
                                          FirebaseAuth.instance.currentUser!.photoURL ?? "https://geeksempire.co/wp-content/uploads/2024/01/Geeks-Empire-Logo.png",
                                          fit: BoxFit.cover,
                                        ),
                                        child: const Image(
                                            image: AssetImage("assets/squircle_shape.png")
                                        )
                                    )
                                )
                            )
                        )
                    )
                ),
                /*
                * End - Profile
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

                                  generatePrototypes();

                                },
                                child: const Image(
                                  image: AssetImage("assets/add.png"),
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

                            },
                            child: const Image(
                              image: AssetImage("assets/menu.png"),
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