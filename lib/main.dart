import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/app_routes.dart';
import 'package:todo_app/data/model/task_model.dart';
import 'package:todo_app/data/model/user_model.dart';
import 'package:todo_app/view/screens/add_task_screen.dart';
import 'package:todo_app/view/screens/home_screen.dart';
import 'package:todo_app/view/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(StatusTaskAdapter());
  await Hive.openBox<UserModel>('User');
  await Hive.openBox<TaskModel>('Tasks');
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: getName() == null ? AppRoutes.profile : AppRoutes.home,
      routes: {
        AppRoutes.profile: (context) => ProfileScreen(),
        AppRoutes.addTask: (context) => AddTaskScreen(),
        AppRoutes.home: (context) => HomeScreen(),
      },
    );
  }

  String? getName() {
    var taskBox = Hive.box<UserModel>('User');
    var user = taskBox.get("UserKey");
    return user?.fullName;
  }
}
