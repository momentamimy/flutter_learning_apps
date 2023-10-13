import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test_project/screens/add_bank.dart';
import 'package:hive_test_project/constants.dart';
import 'package:hive_test_project/model/bank.dart';
import 'package:hive_test_project/screens/edit_bank.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Bank>(Constants.bankBox).listenable(),
          builder: (context, box, child) {

            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final bank = box.getAt(index);
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditBank(bankIndex: index),
                          ));
                    },
                    child: ListTile(
                      title: Text(bank?.name ?? ""),
                      subtitle: Text("${bank?.accountNumber} - ${bank?.amount}"),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddBank(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}