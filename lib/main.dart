import 'package:flutter/material.dart';
import 'package:todo_app/core/app_routes.dart';
import 'package:todo_app/view/screens/add_task_screen.dart';
import 'package:todo_app/view/screens/home_screen.dart';
import 'package:todo_app/view/screens/profile_screen.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.profile, routes: {
        AppRoutes.profile:(context) => ProfileScreen(),
        AppRoutes.addTask :(context) => AddTaskScreen(),
        AppRoutes.home :(context) => HomeScreen(),
      },
    );
  }
}
