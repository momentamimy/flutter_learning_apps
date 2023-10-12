import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_test_project/constants.dart';
import 'package:hive_test_project/model/teacher.dart';
import 'package:hive_test_project/widgets/default_text_field.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({super.key});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final teacherBox = Hive.box<Teacher>(Constants.teacherBox);
  String name = "";
  String age = "";
  String subject = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Teacher")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DefaultTextField(
                  keyboardType: TextInputType.name,
                  validator: (value) =>
                      value?.isEmpty ?? true ? "enter your name" : null,
                  hint: "name",
                  onChange: (val) {
                    name = val;
                  }),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DefaultTextField(
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? "enter your age" : null,
                        hint: "age",
                        onChange: (val) {
                          age = val;
                        }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DefaultTextField(
                        keyboardType: TextInputType.text,
                        validator: (value) => value?.isEmpty ?? true
                            ? "enter your subject"
                            : null,
                        hint: "subject",
                        onChange: (val) {
                          subject = val;
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    _saveTeacher();
                  },
                  child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  _saveTeacher() {
    if (_formKey.currentState?.validate() ?? false) {
      teacherBox.add(Teacher(name: name, age: int.tryParse(age)??0, subject: subject));
      Navigator.pop(context);
    }
  }
}
