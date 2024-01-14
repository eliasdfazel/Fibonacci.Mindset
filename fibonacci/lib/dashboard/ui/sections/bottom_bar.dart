/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/14/24, 10:54 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

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

    return SizedBox(
      height: 111,
      width: 356,
      child: Stack(
        children: [

          /*
           * Start - Background
           */
          const Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
                height: 73,
                width: 356,
                child: Image(
                  image: AssetImage("assets/bar_background.png"),
                )
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
                            mask: Image(
                              image: AssetImage(FirebaseAuth.instance.currentUser!.photoURL ?? "https://geeksempire.co/wp-content/uploads/2024/01/Geeks-Empire-Logo.png"),
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
              child: SizedBox(
                  height: 111,
                  width: 111,
                  child: InkWell(
                    onTap: () async {

                    },
                    child: const Image(
                      image: AssetImage("assets/add.png"),
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
    );
  }

}