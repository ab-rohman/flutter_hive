import 'package:flutter/material.dart';
import 'package:flutter_hive/mapel.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  Hive.registerAdapter(MapelAdapter());
  box.put('mapel', Mapel(title: "Mobile", kelas: "Link Kelas"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Mapel mapel = box.get('mapel');
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive data"),
      ),
      body: Text("${mapel.title} ${mapel.kelas}"),
    );
  }
}
