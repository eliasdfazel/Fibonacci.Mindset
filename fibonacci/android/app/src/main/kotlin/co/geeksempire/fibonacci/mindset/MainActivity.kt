/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/14/24, 8:24 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

package co.geeksempire.fibonacci.mindset

import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
          /* Aligns the Flutter view vertically with the window. */
//        WindowCompat.setDecorFitsSystemWindows(getWindow(), false)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {

             /*
              * Disable the Android splash screen fade out animation to avoid
              * a flicker before the similar frame is drawn in Flutter.
              */
//            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }

        }

        super.onCreate(savedInstanceState)
    }

}
