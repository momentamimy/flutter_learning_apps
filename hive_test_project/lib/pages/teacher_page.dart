import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test_project/add_teacher.dart';
import 'package:hive_test_project/constants.dart';
import 'package:hive_test_project/model/teacher.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Teacher>(Constants.bankBox).listenable(),
          builder: (context, box, child) {
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final teacher = box.getAt(index);
                  return ListTile(
                    title: Text(teacher?.name ?? ""),
                    subtitle: Text("${teacher?.age} - ${teacher?.subject}"),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTeacher(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
