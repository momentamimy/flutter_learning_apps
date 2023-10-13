import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_test_project/constants.dart';
import 'package:hive_test_project/model/bank.dart';
import 'package:hive_test_project/widgets/default_text_field.dart';

class AddBank extends StatefulWidget {
  const AddBank({super.key});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  final bankBox = Hive.box<Bank>(Constants.bankBox);
  String name = "";
  String accountNumber = "";
  String amount = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Bank")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DefaultTextField(
                  keyboardType: TextInputType.name,
                  validator: (value) =>
                      value?.isEmpty ?? true ? "enter bank name" : null,
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
                        validator: (value) => value?.isEmpty ?? true
                            ? "enter account number"
                            : null,
                        hint: "account number",
                        onChange: (val) {
                          accountNumber = val;
                        }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DefaultTextField(
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? "enter amount" : null,
                        hint: "amount",
                        onChange: (val) {
                          amount = val;
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    _saveBank();
                  },
                  child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  _saveBank() {
    if (_formKey.currentState?.validate() ?? false) {
      bankBox.add(Bank(
          name: name,
          accountNumber: int.tryParse(accountNumber) ?? 0,
          amount: double.tryParse(amount) ?? 0));
      Navigator.pop(context);
    }
  }
}
