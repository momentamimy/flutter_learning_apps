import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hint;
  final Function(String)? onChange;
  final TextEditingController? controller;

  const DefaultTextField(
      {super.key, this.keyboardType, this.validator, this.hint, this.onChange, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: (value) => validator?.call(value),
      //value?.isEmpty ?? true ? "enter your name" : null,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: hint),
      onChanged: (val) {
        onChange?.call(val);
      },
    );
  }
}
