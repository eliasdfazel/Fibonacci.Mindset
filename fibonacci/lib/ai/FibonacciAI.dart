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

class FibonacciAI {

  Future<FibonacciDataStructure> generate(int index, int factor) async {

    int fibonacciIndex = index + 2;

    int taskDuration = fibonacciSequence(fibonacciIndex: fibonacciIndex) * factor;

    int taskRest = fibonacciSequence(fibonacciIndex: fibonacciIndex);

    int taskRepeat = (60  / (taskDuration + taskRest)).ceil();

    return FibonacciDataStructure(taskDuration, taskRepeat, taskRest);
  }

  int fibonacciSequence({int fibonacciIndex = 2}) {

    if (fibonacciIndex < 2) {
      throw "Fibonacci Index Should Start From Two";
    }

    return fibonacciSequence(fibonacciIndex: fibonacciIndex - 1) + fibonacciSequence(fibonacciIndex: fibonacciIndex - 2);
  }

}
