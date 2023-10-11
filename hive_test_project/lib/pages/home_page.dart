import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test_project/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeBox = Hive.box(Constants.homeBox);

  @override
  void initState() {
    super.initState();

    homeBox.put("0", "moamen");
    homeBox.put("1", "eltamimy");
    homeBox.put("2", "mohamed");
    homeBox.put("3", "hamouda");
    homeBox.putAll({
      "4": "moamen",
      "5": "eltamimy",
      "6": "mohamed",
      "7": "hamouda",
    });
    homeBox.add("added_name");
    testfun();
  }
  testfun() async {
    var box = await Hive.openBox<String?>('writeNullBox');

    box.values;
    box.put('key', 'value');

    box.put('key', null);
    print("null____________________${box.containsKey('key')}");

    box.delete('key');
    print("delete____________________${box.containsKey('key')}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(homeBox.getAt(0)),
          Text(homeBox.get("0")),
          Text(homeBox.get("1")),
          Text(homeBox.get("2")),
          Text(homeBox.get("3")),
          Text(homeBox.get("4")),
          Text(homeBox.get("5")),
          Text(homeBox.get("6")),
          Text(homeBox.get("7")),
        ],
      ),
    );
  }
}
