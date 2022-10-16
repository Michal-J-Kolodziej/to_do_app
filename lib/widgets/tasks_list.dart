import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../dialogs/delete_task_dialog.dart';
import '../models/task/task.dart';
import '../providers/list_provider.dart';

class TasksList extends ConsumerWidget {
  const TasksList({Key? key, this.isFavList = false}) : super(key: key);

  final bool isFavList;

  void deleteTask(BuildContext context, Task task) async {
    bool shouldDeleteTask = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DeleteTaskDialog();
      },
      barrierDismissible: false,
    );

    if (shouldDeleteTask) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Task> tasksList = !isFavList
        ? ref.watch(tasksListStateProvider)
        : ref
            .watch(tasksListStateProvider)
            .where((Task task) => task.fav)
            .toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: tasksList.length,
      itemBuilder: ((context, index) => ToDoTask(
            key: key,
            task: tasksList[index],
            taskIndex: index,
            updateTaskStage: ((value) => ref
                .read(tasksListStateProvider.notifier)
                .changeTaskState(tasksList[index].id)),
            changeTaskFav: ((value) => ref
                .read(tasksListStateProvider.notifier)
                .changeTaskFav(tasksList[index].id)),
            deleteTask: ((value) => deleteTask(context, tasksList[index])),
          )),
    );
  }
}

class ToDoTask extends StatelessWidget {
  const ToDoTask({
    Key? key,
    required this.task,
    required this.taskIndex,
    required this.updateTaskStage,
    required this.changeTaskFav,
    required this.deleteTask,
  }) : super(key: key);

  final Task task;
  final int taskIndex;
  final ValueChanged<int> updateTaskStage;
  final ValueChanged<int> changeTaskFav;
  final ValueChanged<int> deleteTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PhysicalModel(
        color: Colors.transparent,
        shadowColor: Colors.black,
        elevation: 15.0,
        child: Container(
          decoration: BoxDecoration(
            color: task.color,
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(task.text),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => updateTaskStage(taskIndex),
                      icon: !task.done
                          ? const Icon(Icons.circle_outlined)
                          : const Icon(Icons.circle),
                    ),
                    IconButton(
                      onPressed: () => changeTaskFav(taskIndex),
                      icon: !task.fav
                          ? const Icon(Icons.favorite_border)
                          : const Icon(Icons.favorite),
                    ),
                    IconButton(
                      onPressed: () => deleteTask(taskIndex),
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
