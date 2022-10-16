import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:random_string/random_string.dart';

import '../../classes/utils.dart';
import '../../enums/taskType/task_type.dart';

part 'task.g.dart';

const String tasksBoxName = "tasksBox";

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id = randomAlphaNumeric(20);

  @HiveField(1)
  String text;

  @HiveField(2)
  bool done;

  @HiveField(3)
  bool fav;

  @HiveField(4)
  final Color color = colorsUI[Random().nextInt(colorsUI.length)];

  @HiveField(5)
  TaskType taskType;

  Task(this.text, this.taskType, [this.done = false, this.fav = false]);

  markAsDone() {
    done = !done;
  }

  changeFav() {
    fav = !fav;
  }
}
