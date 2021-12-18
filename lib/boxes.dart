import 'package:hive/hive.dart';
import 'mapel.dart';

class Boxes {
  static Box<Mapel> getMapels() => Hive.box<Mapel>('mapels');
}
