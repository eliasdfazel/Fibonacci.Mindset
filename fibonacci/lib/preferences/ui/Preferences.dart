/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/17/24, 9:28 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:flutter/material.dart';

class PreferencesInterface extends StatefulWidget {

  PreferencesInterface({Key? key}) : super(key: key);

  @override
  State<PreferencesInterface> createState() => _PreferencesInterfaceState();
}
class _PreferencesInterfaceState extends State<PreferencesInterface> {

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorsResources.premiumDark,
            body: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Stack(
                    children: [

                      /*
                         * Start - Decoration
                         */
                      Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/decoration.png"),
                                  fit: BoxFit.cover
                              )
                          )
                      ),

                      const Align(
                          alignment: Alignment.centerRight,
                          child: Opacity(
                              opacity: 0.73,
                              child: Image(
                                image: AssetImage("assets/logo.png"),
                                fit: BoxFit.cover,
                              )
                          )
                      ),
                      /*
                         * End - Decoration
                         */



                    ]
                )
            )
        )
    );
  }

}