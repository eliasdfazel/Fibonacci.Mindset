/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/14/24, 10:18 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/ui/system_bars.dart';
import 'package:flutter/material.dart';

class DashboardInterface extends StatefulWidget {

  bool internetConnection = false;

  DashboardInterface({Key? key, required this.internetConnection}) : super(key: key);

  @override
  State<DashboardInterface> createState() => _DashboardInterfaceState();
}
class _DashboardInterfaceState extends State<DashboardInterface> {

  @override
  void initState() {
    super.initState();

    changeColor(ColorsResources.premiumDark, ColorsResources.premiumDark);

  }

  @override
  Widget build(BuildContext context) {

    if (widget.internetConnection) {



    } else {


    }

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
                        )
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