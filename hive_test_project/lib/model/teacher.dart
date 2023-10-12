import 'package:hive/hive.dart';
import 'package:hive_test_project/constants.dart';

part 'teacher.g.dart';

@HiveType(typeId: Constants.hiveTypeTeacher)
class Teacher {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final String subject;

  Teacher({required this.name, required this.age, required this.subject});
}
