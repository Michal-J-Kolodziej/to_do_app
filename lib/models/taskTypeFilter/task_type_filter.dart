import '../../enums/taskType/task_type.dart';

class TaskTypeFilter {
  TaskType taskType;
  bool applied;
  late String name;

  TaskTypeFilter(this.taskType, [this.applied = true]) {
    name = taskType.name.toString();
  }
}
