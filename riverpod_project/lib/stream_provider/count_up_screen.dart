import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countUpProvider = StreamProvider.autoDispose((ref) => Stream.periodic(
      const Duration(seconds: 1),
      (computationCount) => computationCount,
    ));

class CountUpScreen extends StatelessWidget {
  const CountUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Count_Up_screen_build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Counter Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer(builder: (context, ref, child) {
              return ref.watch(countUpProvider).when(
                  data: (data) => Text(
                        '$data',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                  error: (error, stackTrace) => const Text("error"),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()));
            }),
          ],
        ),
      ),
    );
  }
}
