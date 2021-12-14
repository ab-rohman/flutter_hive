import 'package:flutter/material.dart';
import 'package:flutter_hive/mapel.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'mapel_dialog.dart';
import 'mapels.dart';

late Box box1;
late Box box2;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MapelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final String titleApp = 'Class Scheduller';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
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
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Scheduller"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Mapel>>(
        valueListenable: Mapels.getMapels().listenable(),
        builder: (context, box, _) {
          final mapels = box.values.toList().cast<Mapel>();

          return buildContent(mapels);
        },
      ),
    );
  }

  Widget buildContent(List<Mapel> mapels) {
    if (mapels.isEmpty) {
      return Center(
        child: Text(
          'No Mapels yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Nama Matkul',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: mapels.length,
              itemBuilder: (BuildContext context, int index) {
                final mapel = mapels[index];

                return buildMapel(context, mapel);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildMapel(
    BuildContext context,
    Mapel mapel,
  ) {
    //   final date = DateFormat.yMMMd().format(mapel.createdDate);
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          mapel.title,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(mapel.jam),
        trailing: Text(
          mapel.kelas,
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, mapel),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Mapel mapel) {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
            label: Text('Edit'),
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MapelDialog(
                  mapel: mapel,
                  onClickedDone: (title, kelas, jam) =>
                      editMapel(mapel, title, kelas, jam),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            label: Text('Delete'),
            icon: Icon(Icons.delete),
            onPressed: () => deleteMapel(mapel),
          ),
        )
      ],
    );
  }

  Future addMapel(String title, String kelas, var jam) async {
    final mapel = Mapel()
      ..title = title
      // ..createdDate = DateTime.now()
      ..kelas = kelas
      ..jam = jam;

    final box = Mapels.getMapels();
    box.add(mapel);
  }

  void editMapel(
    Mapel mapel,
    String title,
    String kelas,
    var jam,
  ) {
    mapel.title = title;
    mapel.kelas = kelas;
    mapel.jam = jam;
    mapel.save();
  }

  void deleteMapel(Mapel mapel) {
    mapel.delete();
  }
}
