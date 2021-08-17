//database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:visual_novel_strider/entity/trait_entity.dart';

import 'package:visual_novel_strider/dao/tag_dao.dart';
import 'package:visual_novel_strider/entity/tag_entity.dart';
import 'package:visual_novel_strider/dao/trait_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [TagEntity, TraitEntity])
abstract class AppDatabase extends FloorDatabase {
  TagDao get tagDao;
  TraitsDao get traitDao;
}
