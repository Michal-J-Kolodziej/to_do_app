import 'package:flutter/material.dart';
import 'package:to_do_app/pages/fav_page.dart';

import 'models/task.dart';
import 'pages/home_page.dart';

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
      home: const SwipeTapBar(),
    );
  }
}

class SwipeTapBar extends StatefulWidget {
  const SwipeTapBar({Key? key}) : super(key: key);

  @override
  _SwipeTapBarState createState() => _SwipeTapBarState();
}

class _SwipeTapBarState extends State<SwipeTapBar> {
  final _pageViewController = PageController();

  int _activePage = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[
          const MyHomePage(),
          FavPage(
            tasksList: mockTaskList.where((Task task) => task.fav).toList(),
          ),
        ],
        onPageChanged: (int index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activePage,
        onTap: (int index) {
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todo\'s'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourites'),
        ],
      ),
    );
  }
}
