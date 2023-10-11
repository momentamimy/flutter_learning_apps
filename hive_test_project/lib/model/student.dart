import 'package:hive/hive.dart';
import 'package:hive_test_project/constants.dart';

part 'student.g.dart';

@HiveType(typeId: Constants.hiveTypeStudent)
class Student {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String subject;

  Student({required this.name, required this.age, required this.subject});
}
