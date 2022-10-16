import 'package:flutter/material.dart';
import '../widgets/tasks_list.dart';

class FavPage extends StatelessWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(15.0),
          child: TasksList(
            isFavList: true,
          ),
        ));
  }
}
