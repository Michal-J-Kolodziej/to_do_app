import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String newTask = '';
  final _formKey = GlobalKey<FormState>();

  String? _taskValidator(String? value) {
    if (value != null && value.isEmpty) {
      return 'Task must not be empty';
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
              widget.onSubmit(newTask);
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: _taskValidator,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New task',
                      hintText: 'Enter task',
                    ),
                    onChanged: (value) {
                      setState(() {
                        newTask = value;
                      });
                    },
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
