import 'package:hive/hive.dart';
import 'mapel.dart';

class Mapels {
  static Box<Mapel> getMapels() => Hive.box<Mapel>('mapels');
}
