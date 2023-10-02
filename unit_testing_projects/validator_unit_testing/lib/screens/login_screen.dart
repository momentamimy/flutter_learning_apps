import 'package:flutter/material.dart';
import 'package:validator_unit_testing/q.dart';
import 'package:validator_unit_testing/validator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text("login screen")),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
                validator: (email) => AppValidator.validateEmail(email??""),
                decoration: const InputDecoration(hintText: "enter your email"),
                key: const ValueKey(Q.emailTextFieldId),
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 10),
            TextFormField(
                validator: (password) => AppValidator.validatePassword(password??""),
                decoration: const InputDecoration(hintText: "enter your password"),
                key: const ValueKey(Q.passwordTextFieldId),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(key: const ValueKey(Q.loginButton),onPressed: (){
              formKey.currentState?.validate();
            }, child: const Text("login"))
          ],
        ),
      ),
    );
  }
}
