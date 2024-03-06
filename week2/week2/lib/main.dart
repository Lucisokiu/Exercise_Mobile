import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:week2/pages/feed/screens/feed_screen.dart';
import 'package:week2/utils/certificate_verify_failed.dart';

import 'api/login_api.dart';
import 'model/login.dart';
import 'pages/login/LoginSreen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _checkFuture;

  Future<bool> checkFunc() async {
    print("This is check Func1");
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'login.db'),
    );

    final db = await database;

    // Query the login table for the record with id = 1
    final List<Map<String, Object?>> loginMap = await db.query(
      'login',
      where: 'id = ?',
      whereArgs: [1], // Find record with id = 1
    );

    if (loginMap.isNotEmpty) {
      final Map<String, Object?> record = loginMap.first;
      final userName = record['userName'] as String;
      final password = record['password'] as String;

      dynamic map = createMapLogin(userName, password);
      var response = await apiLogin(map);
      if (response.statusCode == 200) {
        print("This is check = true;");
        return true;
      } else {
        print("This is check = false1;");
        return false;
      }
    } else {
      print("This is check = false2;");
      return false;
    }
  }

  @override
  void initState() {
    _checkFuture = checkFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: FutureBuilder<bool>(
            future: _checkFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Đang chờ kết quả từ Future
                return Container(
                  width: 100, // Đặt chiều rộng mong muốn
                  height: 100, // Đặt chiều cao mong muốn
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                // Đã có kết quả từ Future
                if (snapshot.data == true) {
                  return FeedPage();
                } else {
                  return LoginScreen();
                }
              }
            },
          ),
        );
      },
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
  Future<void> deleteLogin() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'login.db'),
    );

    final db = await database;

    await db.delete(
      'login',
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ấn nút này để load lại chương trình',
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                    (route) => false);
              },
              child: Text("Press"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteLogin();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
              (route) => false);
        },
        tooltip: 'Delelte',
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}
