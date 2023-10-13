import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_test_project/constants.dart';
import 'package:hive_test_project/model/bank.dart';
import 'package:hive_test_project/widgets/default_text_field.dart';

class EditBank extends StatefulWidget {
  final int bankIndex;

  const EditBank({super.key, required this.bankIndex});

  @override
  State<EditBank> createState() => _EditBankState();
}

class _EditBankState extends State<EditBank> {
  final bankBox = Hive.box<Bank>(Constants.bankBox);

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController accountNumberController;
  late TextEditingController amountController;

  @override
  void initState() {
    final bank = bankBox.getAt(widget.bankIndex);
    nameController = TextEditingController(text: bank?.name ?? "");
    accountNumberController =
        TextEditingController(text: "${bank?.accountNumber ?? " "}");
    amountController = TextEditingController(text: "${bank?.amount ?? " "}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Edit Bank"),
          actions: [InkWell(onTap: () async {
            await bankBox.deleteAt(widget.bankIndex);
            Navigator.pop(context);
          },child: const Icon(Icons.delete))]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DefaultTextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) =>
                      value?.isEmpty ?? true ? "enter bank name" : null,
                  hint: "name"),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DefaultTextField(
                        controller: accountNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) => value?.isEmpty ?? true
                            ? "enter account number"
                            : null,
                        hint: "account number"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DefaultTextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value?.isEmpty ?? true ? "enter amount" : null,
                        hint: "amount"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    _editBank();
                  },
                  child: const Text("edit"))
            ],
          ),
        ),
      ),
    );
  }

  _editBank() async {
    if (_formKey.currentState?.validate() ?? false) {
      await bankBox.putAt(
          widget.bankIndex,
          Bank(
              name: nameController.text,
              accountNumber: int.tryParse(accountNumberController.text) ?? 0,
              amount: double.tryParse(amountController.text) ?? 0));
      Navigator.pop(context);
    }
  }
}
