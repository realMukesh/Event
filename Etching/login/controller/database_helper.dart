import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';

class DatabaseHelper {
  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'etching_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static late Database _database;


  static Database get database => _database;

  initializeDatabase() async {
    _database = await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE ${Todo.TABLENAME}(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, email TEXT)");
        });

  }
  insertTodo(Todo todo) async {
    final db = await _database;
    var res = await db?.insert(Todo.TABLENAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("data insert:$res");
    return res;
  }

  deleteTableRecord() async {
    final db = await _database;
    var res = await db?.delete(Todo.TABLENAME);
    print("Table is deleted:$res");
    return res;
  }
  deleteDatabase() async {
   /* // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    await deleteDatabase(path);
// Delete the database*/

  }


  Future<bool> uidExists(email) async {
    print("email :$email");
    var result = await _database.rawQuery(
      "SELECT EXISTS(SELECT 1 FROM ${Todo.TABLENAME} WHERE email='${email.toString().trim()}')",
    );
    print("result :$result");
    int? exists = Sqflite.firstIntValue(result);
    print("exists :$exists");
    return exists == 1;
  }
 /* Future<bool> uidExists(String email) async {
   // var dbClient = await con.db;
    var res = await _database.rawQuery("SELECT * FROM ${Todo.TABLENAME} WHERE id = 1 ");

    print("length${res.length}");
    if (res.length > 0) {
      print("true");
      return true;
     // return new User.fromMap(res.first);
    }

    return false;
  }*/


  Future<List<Todo>> retrieveTodos() async {
    final db = await _database;

    final List<Map<String, dynamic>> maps = await db.query(Todo.TABLENAME);

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        email: maps[i]['name'],
        name: maps[i]['email'],
      );
    });
  }

  updateTodo(Todo todo) async {
    final db = await _database;

    await db.update(Todo.TABLENAME, todo.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteTodo(int id) async {
    var db = await _database;
    db.delete(Todo.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }
}