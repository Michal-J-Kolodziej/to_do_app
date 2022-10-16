import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/task.dart';

class TasksListState extends StateNotifier<List<Task>> {
  TasksListState() : super([]) {
    state = Hive.box<Task>(tasksBoxName).values.toList();
  }

  addTask(Task task) {
    state = [...state, task];
    _saveToBox();
  }

  deleteTask(String taskId) {
    state.removeWhere((Task task) => task.id == taskId);

    state = [...state];
    _saveToBox();
  }

  changeTaskState(String taskId) {
    state.firstWhere((Task task) => task.id == taskId).markAsDone();

    state = [...state];
    _saveToBox();
  }

  changeTaskFav(String taskId) {
    state.firstWhere((Task task) => task.id == taskId).changeFav();

    state = [...state];
    _saveToBox();
  }

  _saveToBox() {
    Hive.box<Task>(tasksBoxName).clear();
    for (var task in state) {
      Hive.box<Task>(tasksBoxName).put(task.id, task);
    }
  }
}

final tasksListStateProvider =
    StateNotifierProvider<TasksListState, List<Task>>(
  (_) {
    return TasksListState();
  },
);
