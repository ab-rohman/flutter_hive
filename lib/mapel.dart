import 'package:hive/hive.dart';

part 'mapel.g.dart';

@HiveType(typeId: 1)
class Mapel {
  Mapel({required this.title, required this.kelas});
  @HiveField(0)
  String title;

  @HiveField(1)
  String kelas;
}
