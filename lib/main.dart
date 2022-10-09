import 'package:flutter/material.dart';

import 'models/task.dart';
import 'pages/input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'To do app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TasksList(
            tasksList: tasksList,
          ),
        ));
  }
}

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

  void deleteTask(int taskIndex) {}

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
                  child: Text(task.text),
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
