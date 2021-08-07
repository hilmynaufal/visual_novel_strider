//database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:visual_novel_strider/tag_dao.dart';
import 'package:visual_novel_strider/entity/tag_entity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [TagEntity])
abstract class AppDatabase extends FloorDatabase {
  TagDao get tagDao;
}
