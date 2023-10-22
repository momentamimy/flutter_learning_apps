import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});
  @override
  Widget build(BuildContext context,ref) {
    print("counter_screen_build");
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
            Consumer(
                builder: (context, ref, child) {
                  return Text(
                    '${ref.watch(counterProvider)}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Row(
          children: [
            FloatingActionButton(
              onPressed: (){
                ref.read(counterProvider.notifier).state--;
              },
              tooltip: 'decrement',
              child: const Icon(Icons.remove),
            ),
            const Spacer(),
            FloatingActionButton(
              onPressed: (){
                ref.read(counterProvider.notifier).state++;
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
