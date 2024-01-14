/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/14/24, 10:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

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

          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
                height: 73,
                width: 356,
                child: Image(
                  image: AssetImage("assets/bar_background.png"),
                )
            ),
          ),

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
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: WidgetMask(
                          blendMode: BlendMode.srcATop,
                          childSaveLayer: true,
                          mask: Image(
                            image: AssetImage("assets/cyborg_girl.jpg"),
                            fit: BoxFit.cover,
                          ),
                          child: Image(
                              image: AssetImage("assets/squircle_shape.png")
                          )
                      )
                    )
                )
            )
          ),

          Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 111,
                  width: 111,
                  child: Image(
                    image: AssetImage("assets/add.png"),
                  )
              )
          ),

          Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                  height: 73,
                  width: 73,
                  child: Image(
                    image: AssetImage("assets/menu.png"),
                  )
              )
          ),

        ]
      ),
    );
  }



}