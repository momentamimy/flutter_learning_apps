import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/future_provider/provider/data_provider.dart';

class FetchBooksScreen extends ConsumerWidget {
  const FetchBooksScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    print("fetch_books_screen_build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Fetch Books Screen"),
      ),
      body: Consumer(builder: (context, ref, child) {
        final booksProvider = ref.watch(booksDataProvider);
        return booksProvider.when(
            data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(
                          "${data[index].name ?? ""} -- ${data[index].auther ?? ""}"),
                      subtitle: Text(data[index].decription ?? ""),
                    )),
            error: (error, stackTrace) => const Text("error"),
            loading: () => const Center(child: CircularProgressIndicator()));
      }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            ref.refresh(booksDataProvider);
          }),
    );
  }
}
