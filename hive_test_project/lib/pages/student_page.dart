import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_test_project/add_student.dart';
import 'package:hive_test_project/constants.dart';
import 'package:hive_test_project/model/student.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final studentBox = Hive.box<Student>(Constants.studentBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: studentBox.length,
          itemBuilder: (context, index) {
            final student = studentBox.getAt(index);
            return ListTile(
              title: Text(student?.name ?? ""),
              subtitle: Text("${student?.age} - ${student?.subject}"),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddStudent(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
