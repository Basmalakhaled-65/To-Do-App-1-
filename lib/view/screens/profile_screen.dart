import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var fullName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xffE8ECF5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.person, size: 100, color: Color(0xff3F51B5)),
            ),
            SizedBox(height: 20),
            Text(
              "Create Your Profile",
              style: TextStyle(fontSize: 20, fontWeight: .bold),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              label: "Full Name",
              controller: fullName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your name";
                }
                return null;
              },
            ),
            SizedBox(height: 50),
            MaterialButton(
              onPressed: () {},
              color: Color(0xff3F51B5),
              padding: EdgeInsets.all(10),
              minWidth: 300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              child: Text(
                "Create",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: .bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    required this.label,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: .bold)),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hint: Text("Enter your name", style: TextStyle(color: Colors.grey)),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }
}
