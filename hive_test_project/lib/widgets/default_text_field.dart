import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hint;
  final Function(String)? onChange;

  const DefaultTextField(
      {super.key, this.keyboardType, this.validator, this.hint, this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
