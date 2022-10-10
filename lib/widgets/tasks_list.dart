import 'package:flutter/material.dart';

import '../dialogs/delete_task_dialog.dart';
import '../models/task.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key, required this.tasksList}) : super(key: key);

  final List<Task> tasksList;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  void updateTaskStage(int taskIndex) {
    Task properTask = widget.tasksList[taskIndex];

    properTask.markAsDone();

    setState(() {});
  }

  void changeTaskFav(int taskIndex) {
    Task properTask = widget.tasksList[taskIndex];

    properTask.changeFav();

    setState(() {});
  }

  void deleteTask(int taskIndex) async {
    bool shouldDeleteTask = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DeleteTaskDialog();
      },
      barrierDismissible: false,
    );

    if (shouldDeleteTask) {
      widget.tasksList.removeAt(taskIndex);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: widget.tasksList.length,
      itemBuilder: ((context, index) => ToDoTask(
            key: widget.key,
            task: widget.tasksList[index],
            taskIndex: index,
            updateTaskStage: updateTaskStage,
            changeTaskFav: changeTaskFav,
            deleteTask: deleteTask,
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
