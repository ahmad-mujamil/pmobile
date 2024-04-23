import 'dart:io';
import 'package:latihan1_jamil002/db/database_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'latihan.db';
    // final path = await getDatabasesPath();
    var directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory();
    // var directory = await getExternalStorageDirectory();
    return join(directory!.path, name);
  }

  Future<Database> initDb() async {
    final path = await fullPath;

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
      singleInstance: true,
    );
    return database;
  }

  Future<void> _createDb(Database db, int version) async =>
      await DatabaseHelper().createTable(db);
}
