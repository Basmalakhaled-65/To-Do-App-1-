import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/model/task_model.dart';
import 'package:todo_app/data/model/user_model.dart';
import 'package:todo_app/view/screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];
  @override
  void initState() {
    super.initState();
    getAlllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          getAlllTasks();
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xffF5F7FB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          spacing: 20,
          children: [
            SizedBox(height: 60),
            HeaderWidget(fullName: getName()),
            TaskInfoDetails(numOfTasks: 12, numOfDone: 5, numOfPending: 7),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => TaskItem(task: tasks[index]),
                itemCount: tasks.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getAlllTasks() {
    var taskBox = Hive.box<TaskModel>('Tasks');
    tasks = taskBox.values.toList();
    setState(() {});
  }

  String getName() {
    var taskBox = Hive.box<UserModel>('User');
    var user = taskBox.get("UserKey");
    return user?.fullName ?? "Error From name";
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.fullName});
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xffE8ECF5),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(Icons.person, size: 40, color: Color(0xff3F51B5)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: .min,
          spacing: 10,
          children: [
            Text(
              "Good morning",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            Text(
              fullName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TaskInfoDetails extends StatelessWidget {
  const TaskInfoDetails({
    super.key,
    required this.numOfTasks,
    required this.numOfPending,
    required this.numOfDone,
  });

  final int numOfTasks;
  final int numOfPending;
  final int numOfDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xff3F51B5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          item(numOfTasks, "Tasks"),
          item(numOfDone, "Done"),
          item(numOfPending, "Pending"),
        ],
      ),
    );
  }

  Widget item(int num, String des) {
    return Column(
      spacing: 10,
      mainAxisSize: .min,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          des,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        spacing: 10,
        children: [
          Container(
            height: 50,
            width: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(task.colorHex),
            ),
          ),
          Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 10,
            children: [
              Text(
                task.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                task.description,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(task.colorHex).withAlpha(100),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.status == StatusTask.pending ? "Pending" : "Done",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(task.colorHex),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
