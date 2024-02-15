import 'package:flash_note/screens/list_screen.dart';
import 'package:flash_note/screens/note_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff7F00FF),
        secondaryHeaderColor: const Color(0xfffff000),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _body = [const NoteScreen(), const ListScreen()];
  final List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Take note'),
    const BottomNavigationBarItem(icon: Icon(Icons.list),label: 'List note',),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(items: _bottomNavigationBarItems, currentIndex: _currentIndex, onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      ),
    );
  }
}