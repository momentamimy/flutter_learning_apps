import 'package:flutter/material.dart';
import 'package:riverpod_project/future_provider/fetch_books_screen.dart';
import 'package:riverpod_project/stream_provider/count_up_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CountUpScreen()));
          },
          child: const Text("go to second page"),
        ),
      ),
    );
  }
}
