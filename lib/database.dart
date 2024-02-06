import 'package:flutter_sqflite_homework/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _database;

  final String tableName = 'Notes';

  Future<Database> initializedb() async {
    _database ??= await createdb();
    return _database!;
  }

  Future<Database> createdb() async {
    final path = await getDatabasesPath();
    var database = await openDatabase(
      join(path, '${tableName}DB.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE $tableName(
            id INTEGER,
            title TEXT,
            description TEXT
          )
          '''
        );
      }
    );
    return database;
  }

  Future insertData(NoteModel model) async {
    var db = await initializedb();
    var result = await db.insert(tableName, model.toMap());
    return result;
  }

  Future<List<NoteModel>> getAllData() async {
    var db = await initializedb();
    List<Map<String, dynamic>> result = await db.query(tableName);
    return List.generate(
      result.length,
      (index) => NoteModel(
        id: result[index]['id'],
        title: result[index]['title'],
        description: result[index]['description'],
      )
    );
  }
}
