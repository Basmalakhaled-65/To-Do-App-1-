import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/model/task_model.dart';
import 'package:todo_app/view/screens/profile_screen.dart';
import 'package:todo_app/view/widgets/custom_material_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String dropdownButtonValue = "Pending";
  var titleTask = TextEditingController();
  var desTask = TextEditingController();
  int colorSelected = 4283215696;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              label: "Title Task",
              hint: "Enter task title",
              controller: titleTask,
            ),
            CustomTextFormField(
              label: "Description",
              hint: "Enter task descriotion",
              maxLines: 4,
              controller: desTask,
            ),
            Text(
              "Status",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              value: dropdownButtonValue,
              isExpanded: true,

              icon: const Icon(Icons.arrow_downward),

              elevation: 16,

              items: [
                DropdownMenuItem(
                  value: "Pending",

                  child: Text(
                    "Pending",

                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),

                DropdownMenuItem(
                  value: "Done",

                  child: Text(
                    "Done",

                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],

              onChanged: (value) {
                dropdownButtonValue = value ?? "Pending";
                setState(() {});
              },
            ),
            Text(
              "Choose Color",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ChooseColorWidget(
              clickColor: (color) {
                color.toString();
                colorSelected = color;
              },
            ),

            SizedBox(height: 35),
            CustomMaterialButton(
              title: "Save Task",
              onPressed: () async {
                ("Title: ${titleTask.text}");
                ("Des: ${desTask.text}");
                ("Status: $dropdownButtonValue");
                ("Color: $colorSelected");
                var taskBox = Hive.box<TaskModel>('cats');
                await taskBox
                    .add(
                      TaskModel(
                        title: titleTask.text,
                        description: desTask.text,
                        status: dropdownButtonValue == "Pending"
                            ? StatusTask.pending
                            : StatusTask.done,
                        colorHex: colorSelected,
                      ),
                    )
                    .then((value) {
                      Navigator.of(context).pop();
                    })
                    .catchError((error) {
                      Navigator.of(context).pop();
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseColorWidget extends StatefulWidget {
  const ChooseColorWidget({super.key, required this.clickColor});
  final void Function(int) clickColor;

  @override
  State<ChooseColorWidget> createState() => _ChooseColorWidgetState();
}

class _ChooseColorWidgetState extends State<ChooseColorWidget> {
  List<int> colorsHex = [0xff2196F3, 0xff4CA550, 0xffFF9800, 0xff9C27B0];
  int selectedColor = 0xff2196F3;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: colorsHex
          .map((e) => colorContainer(e, selectedColor == e))
          .toList(),
    );
  }

  Widget colorContainer(int colorHex, bool isSelected) {
    return InkWell(
      onTap: () {
        selectedColor = colorHex;
        widget.clickColor(selectedColor);
        setState(() {});
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Color(colorHex),
          borderRadius: BorderRadius.circular(50),
          border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
        ),
      ),
    );
  }
}
