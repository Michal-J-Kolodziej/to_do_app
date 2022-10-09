import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../classes/utils.dart';

class Task {
  final String id = randomAlphaNumeric(20);
  String text;
  bool done;
  bool fav;
  final Color color = colorsUI[Random().nextInt(colorsUI.length)];

  Task(this.text, [this.done = false, this.fav = false]);

  markAsDone() {
    done = !done;
  }

  changeFav() {
    fav = !fav;
  }
}

List<Task> mockTaskList = [Task('Clear the room'), Task('Cook dinner')];
