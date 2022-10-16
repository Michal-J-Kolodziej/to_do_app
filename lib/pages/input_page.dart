import 'package:flutter/material.dart';
import 'package:to_do_app/enums/taskType/task_type.dart';

import '../models/task/task.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<Task> onSubmit;

  @override
  // ignore: library_private_types_in_public_api
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String newTaskName = '';
  TaskType taskType = TaskType.home;

  final _formKey = GlobalKey<FormState>();

  String? _taskNameValidator(String? value) {
    if (value != null && value.isEmpty) {
      return 'Task must not be empty';
    }

    return null;
  }

  String? _taskTypeValidator(dynamic value) {
    if (value == null) {
      return 'Task type must not be empty';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new task'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              widget.onSubmit(Task(newTaskName, taskType));

              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: _taskNameValidator,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New task',
                        hintText: 'Enter task',
                      ),
                      onChanged: (value) {
                        setState(() {
                          newTaskName = value;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      validator: _taskTypeValidator,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New task type',
                        hintText: 'Choose task type',
                      ),
                      items: TaskType.values
                          .map<DropdownMenuItem>(
                            ((TaskType e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                )),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            taskType = value;
                          });
                        }
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
