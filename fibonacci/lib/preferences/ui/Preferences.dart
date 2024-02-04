/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/24, 10:02 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/resources/colors_resources.dart';
import 'package:fibonacci/resources/strings_resources.dart';
import 'package:fibonacci/utils/ui/SystemBars.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

                      branding()

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
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                        height: 43,
                        child: InkWell(
                            onTap: () {

                              launchUrl(Uri.parse(StringsResources.applicationLink()), mode: LaunchMode.externalApplication);

                            },
                            child: const Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Image(
                                    image: AssetImage("assets/application_name.png")
                                )
                            )
                        )
                    ),

                    Container(
                        height: 37,
                        padding: const EdgeInsets.only(left: 33),
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
              ),

              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 37),
                      child: SizedBox(
                          height: 81,
                          width: 81,
                          child: InkWell(
                              onTap: () {

                                Share.share('Fibonacci Mindset: Fibonacci AI Will Help You To Focus For Your Work, Studying, Playing ${StringsResources.applicationLink()}',
                                    subject: StringsResources.applicationName());

                              },
                              child: const Image(
                                image: AssetImage("assets/share.png"),
                              )
                          )
                      )
                  )
              )

            ]
        )
    );
  }

}