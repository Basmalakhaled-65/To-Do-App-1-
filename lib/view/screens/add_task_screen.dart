import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_app/view/screens/profile_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String dropdownButtonValue = "Pending";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(fontSize: 25, fontWeight: .bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            CustomTextFormField(label: "Title Task", hint: "Enter task title"),
            CustomTextFormField(
              label: "Description",
              hint: "Enter task descriotion",
              maxLines: 4,
            ),
            Text(
            
              "Status", style: TextStyle(fontSize: 16, fontWeight: .bold)),
            DropdownButton(
              value: dropdownButtonValue,

              icon: const Icon(Icons.arrow_downward),

              elevation: 16,

              items: [
                DropdownMenuItem(
                  value: "Pending",

                  child: Text(
                    "Pending",

                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                ),

                DropdownMenuItem(
                  value: "Done",

                  child: Text(
                    "Done",

                    style: TextStyle(fontSize: 16, fontWeight: .w500),
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
              style: TextStyle(fontSize: 16, fontWeight: .bold),
            ),
            ChooseColorWidget(),
            SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5965A0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Save Task",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseColorWidget extends StatefulWidget {
  const ChooseColorWidget({super.key});

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
