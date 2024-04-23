import 'package:intl/intl.dart';
import 'package:latihan1_jamil002/db/database_service.dart';
import 'package:latihan1_jamil002/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final tableUser = 'users';

  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $tableUser (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nim TEXT DEFAULT NULL,
        nama TEXT DEFAULT NULL,
        jurusan TEXT DEFAULT NULL
      )
    ''');
  
  }

  Future<int> createUser(User user) async {
    final database = await DatabaseService().database;
    return await database.insert(tableUser, user.toJson());    
  }

  Future<List<User>> getUsers() async {
    final database = await DatabaseService().database;
    final users = await database
        .rawQuery('''SELECT * FROM $tableUser ORDER BY nama''');
    return users.map((data) => User.fromJson(data)).toList();
  }

  Future<int> deleteUser(User user) async {
    final database = await DatabaseService().database;
    return await database.delete(tableUser,where: "id = ?",whereArgs: [user.id]);    
  }

  Future<int> updateUser(User user,int id) async {
    final database = await DatabaseService().database;
    return await database.update(tableUser,user.toJson(),where: "id = ?",whereArgs: [id]);    
  }
  
  Future<List<User>> getUserByNim(String nim) async {
    final database = await DatabaseService().database;
    final users = await database
        .rawQuery('''SELECT * FROM $tableUser WHERE nim = $nim ''');
    return users.map((data) => User.fromJson(data)).toList();
  }
}
