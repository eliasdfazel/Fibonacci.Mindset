/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/22/24, 12:42 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

class StringsResources {

  static String applicationName() {

    return "Fibonacci Mindset";
  }

  /*
   * Start - Titles
   */
  static String geeksEmpire() {

    return "Geeks Empire";
  }

  static String profileTitle() {

    return "Profile";
  }

  static String previewTitle() {

    return "Previews";
  }

  static String searchTitle() {

    return "Search";
  }
  static String searchHint() {

    return "Search In Tasks";
  }

  static String titleTitle() {

    return "Title";
  }
  static String titleHint() {

    return "Title Of Task";
  }

  static String descriptionTitle() {

    return "Description";
  }
  static String descriptionHint() {

    return "Description Of Task";
  }

  static String locationTitle() {

    return "Location";
  }
  static String locationHint() {

    return  "Location Of Task";
  }

  static String alarmHint() {

    return "Note On Task";
  }

  static String categoriesTitle() {

    return "Categories";
  }

  static String colorsTagsTitle() {

    return "Colors Tags";
  }

  static String alarmsTitle() {

    return "Alarms";
  }

  static String fibonacciAiTitle() {

    return "Fibonacci AI";
  }
  static String fibonacciAiDescription() {

    return "It will suggest alarms suitable to your tasks requirements.";
  }

  static String fibonacciNotice() {

    return "Fibonacci AI Needs You To Select A Category";
  }

  static String duration() {

    return "Duration";
  }
  static String repeat() {

    return "Repeat";
  }
  static String rest() {

    return "Rest";
  }
  /*
   * End - Titles
   */

  /*
   * Start - Links
   */
  static String applicationLink() {

    String applicationLink = "https://play.google.com/store/apps/details?id=co.geeksempire.fibonacci.mindset";

    if (Platform.isAndroid) {

      applicationLink = "https://play.google.com/store/apps/details?id=co.geeksempire.fibonacci.mindset";

    } else {

      applicationLink = "";

    }

    applicationLink = "https://xdaforums.com/t/fibonacci-ai-fibonacci-mindset-public-alpha-stage.4654966";

    return applicationLink;
  }
  /*
   * End - Links
   */

  /*
   * Start - Action
   */
  static String add() {

    return "Add";
  }
  /*
   * End - Action
   */

  /*
   * Start - Notice
   */
  static String addTask() {

    return "Click On ADD \nTo Configure A Task";
  }

  static String ok() {

    return "OK";
  }

  static String tos() {

    return "Terms Of Services";
  }

  static String privacyPolicy() {

    return "Privacy Policy";
  }
  /*
   * End - Notice
   */

  /*
   * Start - Warnings
   */
  static String noInternetConnection() {

    return "No Internet Connection...";
  }

  static String warningEmptyText() {

    return "You Didn't Entered Text | Error Occurred";
  }
  /*
   * End - Warnings
   */

  /*
   * Start - Social Media
   */
  static String privacyPolicyLink() {

    return "https://geeksempire.co/privacypolicy/";
  }

  static String tosLink() {

    return "https://geeksempire.co/sachiel-ai-trading-signals/term-of-services/";
  }

  static String instagramLink() {

    return "https://www.instagram.com/geeksempire.co";
  }

  static String youtubeLink() {

    return "https://www.youtube.com/@GeeksEmpireCo/";
  }

  static String threadsLink() {

    return "https://www.threads.net/@geeksempire.co";
  }
  /*
   * End - Social Media
   */

}