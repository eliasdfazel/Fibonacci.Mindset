/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/17/24, 8:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:fibonacci/preferences/io/PreferencesIO.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:flutter/material.dart';

class PreferencesInterface extends StatefulWidget {

  PreferencesInterface({Key? key}) : super(key: key);

  @override
  State<PreferencesInterface> createState() => _PreferencesInterfaceState();
}
class _PreferencesInterfaceState extends State<PreferencesInterface> {

  PreferencesIO preferencesIO = PreferencesIO();

  Widget tasksPlaceholder = Container();

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.applicationName(),
            color: ColorsResources.premiumDark,
            theme: ThemeData(
              fontFamily: 'Ubuntu',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.premiumDark),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              }),
            ),
            home: Scaffold(
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

                          const Blur(
                              blur: 13.0,
                              colorOpacity: 0,
                              blurColor: Colors.transparent,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Opacity(
                                      opacity: 0.73,
                                      child: Image(
                                        image: AssetImage("assets/decoration_end.png"),
                                        fit: BoxFit.cover,
                                      )
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
        )
    );
  }

}