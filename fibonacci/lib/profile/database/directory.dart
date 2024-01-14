/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/14/24, 8:54 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

String profilesDocumentPath(String emailAddress) {

  String firestorePath = "Fibonacci/Mindset/Profiles/${emailAddress.toUpperCase()}";

  return firestorePath;
}