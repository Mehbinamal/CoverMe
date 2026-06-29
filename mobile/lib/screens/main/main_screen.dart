import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../tasks/tasks_screen.dart';
import '../teachers/teacher_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  final pages = const [

    HomeScreen(),

    TasksScreen(),

    TeachersScreen(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: NavigationBar(

        selectedIndex: currentIndex,

        onDestinationSelected: (index){

          setState(() {

            currentIndex = index;

          });

        },

        destinations: const [

          NavigationDestination(

            icon: Icon(Icons.home_outlined),

            selectedIcon: Icon(Icons.home),

            label: "Home",

          ),

          NavigationDestination(

            icon: Icon(Icons.assignment_outlined),

            selectedIcon: Icon(Icons.assignment),

            label: "Tasks",

          ),

          NavigationDestination(

            icon: Icon(Icons.people_outline),

            selectedIcon: Icon(Icons.people),

            label: "Teachers",

          ),

        ],

      ),

    );

  }
}