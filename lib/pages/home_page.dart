import 'package:flutter/material.dart';

import '../dialogs/delete_task_dialog.dart';
import '../models/task.dart';
import '../widgets/tasks_list.dart';
import 'input_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasksList = mockTaskList.sublist(0);

  void _addTask(String task) {
    Task newTask = Task(task);

    tasksList.add(newTask);
    setState(() {});
  }

  void _goToInputPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return InputPage(
        onSubmit: _addTask,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(onPressed: _goToInputPage, icon: const Icon(Icons.input))
          ],
          title: const Text('To do app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TasksList(
            tasksList: tasksList,
          ),
        ));
  }
}
