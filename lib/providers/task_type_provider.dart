import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/taskType/task_type.dart';
import '../models/taskTypeFilter/task_type_filter.dart';

class TaskTypeState extends StateNotifier<List<TaskTypeFilter>> {
  TaskTypeState()
      : super(TaskType.values.map((e) => TaskTypeFilter(e)).toList());

  changeApplied(TaskTypeFilter taskType) {
    state.firstWhere((element) => element.name == taskType.name).applied =
        !taskType.applied;

    state = [...state];
  }

  List<TaskTypeFilter> getApplied() {
    return state.where((TaskTypeFilter taskType) => taskType.applied).toList();
  }
}

final taskTypeListStateProvider =
    StateNotifierProvider<TaskTypeState, List<TaskTypeFilter>>(
  (_) {
    return TaskTypeState();
  },
);
