import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/task.dart';

class TasksListState extends StateNotifier<List<Task>> {
  TasksListState() : super(mockTaskList);

  addTask(Task task) {
    state = [...state, task];
  }

  deleteTask(String taskId) {
    state.removeWhere((Task task) => task.id == taskId);
    state = [...state];
  }

  changeTaskState(String taskId) {
    state.firstWhere((Task task) => task.id == taskId).markAsDone();
    state = [...state];
  }

  changeTaskFav(String taskId) {
    state.firstWhere((Task task) => task.id == taskId).changeFav();
    state = [...state];
  }
}

final tasksListStateProvider =
    StateNotifierProvider<TasksListState, List<Task>>(
  (_) {
    return TasksListState();
  },
);
