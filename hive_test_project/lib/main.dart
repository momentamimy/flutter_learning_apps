import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_test_project/constants.dart';
import 'package:hive_test_project/model/bank.dart';
import 'package:hive_test_project/model/student.dart';
import 'package:hive_test_project/model/teacher.dart';
import 'package:hive_test_project/pages/bank_page.dart';
import 'package:hive_test_project/pages/home_page.dart';
import 'package:hive_test_project/pages/student_page.dart';
import 'package:hive_test_project/pages/teacher_page.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(const MyApp());
}

initHive() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter(Constants.hiveDBName);

  Hive.registerAdapter<Student>(StudentAdapter());
  Hive.registerAdapter<Teacher>(TeacherAdapter());
  Hive.registerAdapter<Bank>(BankAdapter());

  const secureStorage = FlutterSecureStorage();
  final encryptionKeyString = await secureStorage.read(key: Constants.hiveBankSecureKey);
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: Constants.hiveBankSecureKey,
      value: base64UrlEncode(key),
    );
  }
  final key = await secureStorage.read(key: Constants.hiveBankSecureKey);
  final encryptionKeyUint8List = base64Url.decode(key!);
  print('Encryption key Uint8List: $encryptionKeyUint8List');

  await Hive.openBox(Constants.homeBox);
  await Hive.openBox<Student>(Constants.studentBox);
  await Hive.openBox<Teacher>(Constants.teacherBox);
  await Hive.openBox<Bank>(Constants.bankBox,encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Hive'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  final pages = const [HomePage(), StudentPage(), TeacherPage(), BankPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() => selectedIndex = value);
          },
          currentIndex: selectedIndex,
          backgroundColor: Colors.teal,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "student", icon: Icon(Icons.person)),
            BottomNavigationBarItem(label: "teacher", icon: Icon(Icons.person)),
            BottomNavigationBarItem(label: "bank", icon: Icon(Icons.money)),
          ]),
    );
  }
}
