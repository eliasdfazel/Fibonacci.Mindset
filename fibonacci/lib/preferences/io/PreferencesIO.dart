/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/16/24, 10:29 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/preferences/keys/PreferencesKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesIO {

  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  Future<int> retrieveCategorizedBy() async {

    int categorizedBy = (await _sharedPreferences).getInt(PreferencesKeys.categorizedBy) ?? 0;

    return categorizedBy;
  }

}