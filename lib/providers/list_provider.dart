import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_app/providers/task_type_provider.dart';

import '../models/task/task.dart';
import '../models/taskTypeFilter/task_type_filter.dart';

class TasksListState extends StateNotifier<List<Task>> {
  late final List<Task> _oryginalList;
  List<TaskTypeFilter> _taskTypes = [];

  TasksListState(Ref ref) : super([]) {
    _oryginalList = Hive.box<Task>(tasksBoxName).values.toList();

    state = _oryginalList;

    ref.listen(taskTypeListStateProvider, (previous, next) {
      _taskTypes = next;
      _filterState();
    });
  }

  addTask(Task task) {
    _oryginalList = [..._oryginalList, task];
    _filterState();
    _saveToBox();
  }

  deleteTask(String taskId) {
    _oryginalList.removeWhere((Task task) => task.id == taskId);

    _oryginalList = [..._oryginalList];
    _filterState();
    _saveToBox();
  }

  changeTaskState(String taskId) {
    _oryginalList.firstWhere((Task task) => task.id == taskId).markAsDone();

    _oryginalList = [..._oryginalList];
    _filterState();
    _saveToBox();
  }

  changeTaskFav(String taskId) {
    _oryginalList.firstWhere((Task task) => task.id == taskId).changeFav();

    _oryginalList = [..._oryginalList];
    _filterState();
    _saveToBox();
  }

  _saveToBox() {
    Hive.box<Task>(tasksBoxName).clear();
    for (var task in _oryginalList) {
      Hive.box<Task>(tasksBoxName).put(task.id, task);
    }
  }

  _filterState() {
    state = _oryginalList.where((Task oryginalTask) {
      return _taskTypes.any((taskType) =>
          taskType.applied && oryginalTask.taskType == taskType.taskType);
    }).toList();
  }
}

final tasksListStateProvider =
    StateNotifierProvider<TasksListState, List<Task>>(
  (ref) {
    return TasksListState(ref);
  },
);
