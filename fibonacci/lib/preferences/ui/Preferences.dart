/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:02 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/preferences/io/keys/PreferencesKeys.dart';
import 'package:fibonacci/preferences/ui/elements/PreferencesBottomBar.dart';
import 'package:fibonacci/preferences/ui/elements/Switch.dart';
import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/actions/BarActions.dart';
import 'package:fibonacci/utils/navigations/NavigationCommands.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PreferencesInterface extends StatefulWidget {

  PreferencesInterface({Key? key}) : super(key: key);

  @override
  State<PreferencesInterface> createState() => _PreferencesInterfaceState();
}
class _PreferencesInterfaceState extends State<PreferencesInterface> implements BarActions {

  SwitchInterface fibonacciAI = SwitchInterface(preferencesTitle: StringsResources.fibonacciAiTitle(), preferencesDescription: StringsResources.fibonacciAiDescription(), preferencesKey: PreferencesKeys.fibonacciAI);

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

                      ListView(
                        padding: const EdgeInsets.fromLTRB(37, 73, 37, 73),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: [

                          branding(),

                          const Divider(height: 37, color: Colors.transparent),

                          fibonacciAI,

                          const Divider(height: 37, color: Colors.transparent),

                        ]
                      ),

                      /*
                       * Start - Bottom Bar
                       */
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 37),
                              child: PreferencesBottomBarInterface(bottomBarActions: this)
                          )
                      )
                      /*
                       * End - Bottom Bar
                       */

                    ]
                )
            )
        )
    );
  }

  Widget branding() {

    return SizedBox(
        height: 87,
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                  height: 43,
                  child: InkWell(
                      onTap: () {

                        launchUrl(Uri.parse(StringsResources.applicationLink()), mode: LaunchMode.externalApplication);

                      },
                      child: Transform.translate(
                          offset: const Offset(-11, 0),
                          child: const Image(
                              image: AssetImage("assets/application_name.png")
                          )
                      )
                  )
              ),

              Container(
                  height: 37,
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                                height: 37,
                                width: 37,
                                child: InkWell(
                                    onTap: () {

                                      launchUrl(Uri.parse(StringsResources.instagramLink()), mode: LaunchMode.externalApplication);

                                    },
                                    child: const Image(
                                      image: AssetImage("assets/instagram.png"),
                                      height: 37,
                                      width: 37,
                                    )
                                )
                            )
                        ),

                        const SizedBox(
                          width: 13,
                        ),

                        Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                                height: 37,
                                width: 37,
                                child: InkWell(
                                    onTap: () {

                                      launchUrl(Uri.parse(StringsResources.threadsLink()), mode: LaunchMode.externalApplication);

                                    },
                                    child: const Image(
                                      image: AssetImage("assets/threads.png"),
                                      height: 37,
                                      width: 37,
                                    )
                                )
                            )
                        ),

                        const SizedBox(
                          width: 13,
                        ),

                        Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                                height: 37,
                                width: 37,
                                child: InkWell(
                                    onTap: () {

                                      launchUrl(Uri.parse(StringsResources.youtubeLink()), mode: LaunchMode.externalApplication);

                                    },
                                    child: const Image(
                                      image: AssetImage("assets/youtube.png"),
                                      height: 37,
                                      width: 37,
                                    )
                                )
                            )
                        )

                      ]
                  )
              )

            ]
        )
    );
  }

  @override
  void centerAction({int barType = BarActions.typeBottomBar}) {

    Share.share('Fibonacci Mindset: Fibonacci AI Will Help You To Focus For Your Work, Studying, Playing ${StringsResources.applicationLink()}',
        subject: StringsResources.applicationName());

  }

  @override
  void leftAction({int barType = BarActions.typeBottomBar}) {

    navigatePop(context);

  }

  @override
  void rightAction({int barType = BarActions.typeBottomBar}) {

    launchUrl(Uri.parse(StringsResources.applicationLink()), mode: LaunchMode.externalApplication);

  }

}