/*
 * Copyright © 2024 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/6/24, 8:02 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fibonacci/ai/data/FibonacciDataStructure.dart';
import 'package:flutter/cupertino.dart';

class FibonacciAI {

  Future<FibonacciDataStructure> generate(int index, int factor) async {

    int fibonacciIndex = index + 2;

    int taskDuration = _fibonacciTaskDuration(fibonacciIndex, factor);

    int taskRest = _fibonacciSequence(fibonacciIndex: fibonacciIndex);

    int taskRepeat = _fibonacciTaskRepeat(taskDuration, taskRest);

    return FibonacciDataStructure(taskDuration, taskRepeat, taskRest);
  }

  int _fibonacciSequence({int fibonacciIndex = 2}) {

    int fibonacciValue = 0;

    if (fibonacciIndex == 0 || fibonacciIndex == 1) {
      debugPrint("Fibonacci AI Error");

      fibonacciValue = fibonacciIndex;

    } else {

      fibonacciValue = _fibonacciSequence(fibonacciIndex: fibonacciIndex - 1) + _fibonacciSequence(fibonacciIndex: fibonacciIndex - 2);
      debugPrint("Fibonacci Value At $fibonacciIndex: $fibonacciValue");

    }

    return fibonacciValue;
  }

  int _fibonacciTaskDuration(int fibonacciIndex, int factor) {

    return _fibonacciSequence(fibonacciIndex: fibonacciIndex) * factor;
  }

  int _fibonacciTaskRepeat(int taskDuration, int taskRest) {

    return (60  / (taskDuration + taskRest)).ceil();
  }

}
