/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/24, 1:16 PM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

String rhythmsCollectionsPath(String emailAddress) {

  String firestorePath = "Fibonacci/Mindset/Profiles/${emailAddress.toUpperCase()}/Rhythms";

  return firestorePath;
}