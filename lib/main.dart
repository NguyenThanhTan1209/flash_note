import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nested/nested.dart';
import 'business_logic/blocs/list_file/list_file_bloc.dart';
import 'business_logic/blocs/list_item_detail/list_item_detail_bloc.dart';
import 'business_logic/blocs/note/note_bloc.dart';
import 'view/screens/list_screen.dart';
import 'view/screens/note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<NoteBloc>(
          create: (BuildContext context) => NoteBloc(),
        ),
        BlocProvider<ListFileBloc>(
          create: (BuildContext context) => ListFileBloc(),
        ),
        BlocProvider<ListItemDetalBloc>(
          create: (BuildContext context) => ListItemDetalBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xff7F00FF),
          secondaryHeaderColor: const Color(0xfffff000),
          textTheme: GoogleFonts.interTextTheme(),
        ),
        home: const HomePage(),
      ),
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
  final List<Widget> _body = <Widget>[const NoteScreen(), const ListScreen()];
  final List<BottomNavigationBarItem> _bottomNavigationBarItems =
      <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: 'Take note',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'List note',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _currentIndex,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
