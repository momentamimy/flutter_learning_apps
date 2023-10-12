import 'package:hive/hive.dart';
import 'package:hive_test_project/constants.dart';

part 'bank.g.dart';

@HiveType(typeId: Constants.hiveTypeBank)
class Bank {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int accountNumber;
  @HiveField(2)
  final double amount;

  Bank({required this.name, required this.accountNumber, required this.amount});
}
