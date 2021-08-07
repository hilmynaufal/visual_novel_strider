// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TagDao? _tagDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tags` (`id` INTEGER, `applicable` INTEGER NOT NULL, `cat` TEXT NOT NULL, `description` TEXT NOT NULL, `meta` INTEGER NOT NULL, `name` TEXT NOT NULL, `parents` INTEGER, `searchable` INTEGER NOT NULL, `vns` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TagDao get tagDao {
    return _tagDaoInstance ??= _$TagDao(database, changeListener);
  }
}

class _$TagDao extends TagDao {
  _$TagDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _tagEntityInsertionAdapter = InsertionAdapter(
            database,
            'tags',
            (TagEntity item) => <String, Object?>{
                  'id': item.id,
                  'applicable': item.applicable ? 1 : 0,
                  'cat': item.cat,
                  'description': item.description,
                  'meta': item.meta ? 1 : 0,
                  'name': item.name,
                  'parents': item.parents,
                  'searchable': item.searchable ? 1 : 0,
                  'vns': item.vns
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TagEntity> _tagEntityInsertionAdapter;

  @override
  Future<List<TagEntity>> findAllTags() async {
    return _queryAdapter.queryList('select * from tags',
        mapper: (Map<String, Object?> row) => TagEntity(
            applicable: (row['applicable'] as int) != 0,
            cat: row['cat'] as String,
            description: row['description'] as String,
            id: row['id'] as int?,
            meta: (row['meta'] as int) != 0,
            name: row['name'] as String,
            parents: row['parents'] as int?,
            searchable: (row['searchable'] as int) != 0,
            vns: row['vns'] as int));
  }

  @override
  Future<List<TagEntity?>> findTagById(List<int> id) async {
    const offset = 1;
    final _sqliteVariablesForId =
        Iterable<String>.generate(id.length, (i) => '?${i + offset}').join(',');
    return _queryAdapter.queryList(
        'select * from tags where id in (' + _sqliteVariablesForId + ')',
        mapper: (Map<String, Object?> row) => TagEntity(
            applicable: (row['applicable'] as int) != 0,
            cat: row['cat'] as String,
            description: row['description'] as String,
            id: row['id'] as int?,
            meta: (row['meta'] as int) != 0,
            name: row['name'] as String,
            parents: row['parents'] as int?,
            searchable: (row['searchable'] as int) != 0,
            vns: row['vns'] as int),
        arguments: [...id]);
  }

  @override
  Future<void> insertTag(TagEntity tagEntity) async {
    await _tagEntityInsertionAdapter.insert(
        tagEntity, OnConflictStrategy.replace);
  }
}
