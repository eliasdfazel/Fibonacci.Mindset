/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/4/24, 10:42 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

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
import 'package:flutter/material.dart';

class SwitchInterface extends StatefulWidget {

  String preferencesTitle;
  String preferencesDescription;

  String preferencesKey;

  SwitchInterface({Key? key, required this.preferencesTitle, required this.preferencesDescription, required this.preferencesKey}) : super(key: key);

  @override
  State<SwitchInterface> createState() => _SwitchInterfaceState();
}
class _SwitchInterfaceState extends State<SwitchInterface> {

  bool switchStatus = false;

  double offOpacity = 1;
  double onOpacity = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Blur(
      blur: 13,
      borderRadius: BorderRadius.circular(19),
      blurColor: Colors.transparent,
      overlay: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsResources.premiumDark.withOpacity(0.73),
                ColorsResources.premiumDark.withOpacity(0.37)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [




                ]
              ),

              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    debugPrint("Switching... $switchStatus");

                    setState(() {

                      switchStatus = !switchStatus;

                      if (switchStatus) {

                        onOpacity = 1;
                        offOpacity = 0;

                      } else {

                        onOpacity = 0;
                        offOpacity = 1;

                      }

                    });

                  },
                  child: Stack(
                      children: [

                        AnimatedOpacity(
                            opacity: onOpacity,
                            duration: const Duration(milliseconds: 357),
                            curve: Curves.easeIn,
                            child: const Image(
                              image: AssetImage("assets/switch_on.png"),
                            )
                        ),

                        AnimatedOpacity(
                            opacity: offOpacity,
                            duration: const Duration(milliseconds: 357),
                            curve: Curves.easeIn,
                            child: const Image(
                              image: AssetImage("assets/switch_off.png"),
                            )
                        )

                      ]
                  )
                )
              ),

            ]
          )
        )
      ),
      child: const SizedBox(height: 101)
    );
  }

}