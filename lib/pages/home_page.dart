import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/task/task.dart';
import '../providers/list_provider.dart';
import '../widgets/task_type_filter_list.dart';
import '../widgets/tasks_list.dart';
import 'input_page.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  void _addTask(Task task, WidgetRef ref) {
    ref.read(tasksListStateProvider.notifier).addTask(task);
  }

  void _goToInputPage(BuildContext context, WidgetRef ref) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return InputPage(
            onSubmit: (task) => _addTask(task, ref),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () => _goToInputPage(context, ref),
              icon: const Icon(Icons.input))
        ],
        title: const Text('To do app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: const <Widget>[
            TaskTypeFilterList(),
            Expanded(child: TasksList()),
          ],
        ),
      ),
    );
  }
}
