/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 10:03 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

String rhythmsCollectionsPath(String emailAddress) {

  String firestorePath = "Fibonacci/Mindset/Profiles/${emailAddress.toUpperCase()}/Rhythms";

  return firestorePath;
}