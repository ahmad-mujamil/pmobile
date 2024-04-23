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
  // Future<List<TarifSqfliteModel>> fetchTarifByGol({required String gol}) async {
  //   final database = await DatabaseService().database;
  //   var mapList = await database
  //       .rawQuery('SELECT * FROM $tableTarif WHERE cKdGol= "$gol" ');
  //   return mapList.map((data) => TarifSqfliteModel.fromJson(data)).toList();
  // }

  // Future<List<DiameterSqfliteModel>> fetchAllDiameter() async {
  //   final database = await DatabaseService().database;
  //   var mapList = await database.rawQuery('SELECT * FROM $tableDiameter ');
  //   return mapList.map((data) => DiameterSqfliteModel.fromJson(data)).toList();
  // }

  // Future<List<DiameterSqfliteModel>> fetchDiameterById(
  //     {required String id}) async {
  //   final database = await DatabaseService().database;
  //   var mapList = await database
  //       .rawQuery('SELECT * FROM $tableDiameter WHERE id= "$id" ');
  //   return mapList.map((data) => DiameterSqfliteModel.fromJson(data)).toList();
  // }

  // Future<List<ByAdminSqfliteModel>> fetchAllByAdmin() async {
  //   final database = await DatabaseService().database;
  //   var mapList = await database.rawQuery('SELECT * FROM $tableByAdmin ');
  //   return mapList.map((data) => ByAdminSqfliteModel.fromJson(data)).toList();
  // }

  // Future<List<ByAdminSqfliteModel>> fetchByAdminByGol(
  //     {required String gol}) async {
  //   final database = await DatabaseService().database;
  //   var mapList = await database
  //       .rawQuery('SELECT * FROM $tableByAdmin WHERE cKdGol= "$gol" ');
  //   return mapList.map((data) => ByAdminSqfliteModel.fromJson(data)).toList();
  // }

  // Future<List<BacaanSqfliteModel>> fetchDataSudahCatat() async {
  //   final database = await DatabaseService().database;
  //   final bacaan = await database.rawQuery(
  //       '''SELECT * FROM $tableBacameter Where dTglCatat Is Not Null ORDER BY cIdPel''');
  //   return bacaan.map((data) => BacaanSqfliteModel.fromJson(data)).toList();
  // }

  // Future<List<BacaanSqfliteModel>> fetchDataBelumUpload() async {
  //   final database = await DatabaseService().database;
  //   final bacaan = await database.rawQuery(
  //       '''SELECT * FROM $tableBacameter Where dTglCatat Is Not Null AND dTglUpload is null ORDER BY cIdPel''');
  //   return bacaan.map((data) => BacaanSqfliteModel.fromJson(data)).toList();
  // }

  // Future<int> updatePelangganBelumUpload() async {
  //   final database = await DatabaseService().database;
  //   return await database.update(
  //     tableBacameter,
  //     {
  //       'dTglUpload': null,
  //     },
  //     where: 'dTglUpload IS NOT NULL',
  //   );
  // }

  // Future<List<Map<String, dynamic>>> fetchDataSisaByWilayah() async {
  //   final database = await DatabaseService().database;
  //   final data = await database.rawQuery(
  //       '''SELECT vcJalan,vcWilayah, count(*) as jumlah FROM $tableBacameter  GROUP BY vcJalan ORDER BY vcJalan''');
  //   return data;
  // }

  // Future<List<BacaanSqfliteModel>> getJumlahSudahCatatByWilayah(
  //     {required String namaWilayah}) async {
  //   final database = await DatabaseService().database;
  //   final bacaan = await database.rawQuery(
  //       '''SELECT * FROM $tableBacameter Where dTglCatat IS NOT NULL AND vcJalan = '$namaWilayah' ORDER BY cIdPel''');
  //   return bacaan.map((data) => BacaanSqfliteModel.fromJson(data)).toList();
  // }

  // Future<List<BacaanSqfliteModel>> getPelangganByWilayah(
  //     {required String namaWilayah}) async {
  //   final database = await DatabaseService().database;
  //   final bacaan = await database.rawQuery(
  //       '''SELECT * FROM $tableBacameter Where vcJalan = '$namaWilayah' ORDER BY cIdPel''');
  //   return bacaan.map((data) => BacaanSqfliteModel.fromJson(data)).toList();
  // }

  // Future<List<BacaanSqfliteModel>> getBelumUploadPelanggan() async {
  //   final database = await DatabaseService().database;
  //   final bacaan = await database.rawQuery(
  //       '''SELECT * FROM $tableBacameter Where dTglUpload Is Null AND dTglCatat Is Not Null ORDER BY dTglCatat DESC limit 50''');
  //   return bacaan.map((data) => BacaanSqfliteModel.fromJson(data)).toList();
  // }

  // Future<List<BacaanSqfliteModel>> getDigitAkhirPelanggan(
  //     {required String key}) async {
  //   final database = await DatabaseService().database;
  //   final bacaan = await database.rawQuery(
  //       '''SELECT * FROM $tableBacameter Where cIdPel LIKE '%$key' ORDER BY cIdPel''');
  //   return bacaan.map((data) => BacaanSqfliteModel.fromJson(data)).toList();
  // }

  // Future<int> deleteBacameter() async {
  //   final database = await DatabaseService().database;
  //   return await database.delete(tableBacameter);
  // }

  // Future<int> deleteStatus() async {
  //   final database = await DatabaseService().database;
  //   return await database.delete(tableStatus);
  // }

  // Future<int> deleteTarif() async {
  //   final database = await DatabaseService().database;
  //   return await database.delete(tableTarif);
  // }

  // Future<int> deleteByAdmin() async {
  //   final database = await DatabaseService().database;
  //   return await database.delete(tableByAdmin);
  // }

  // Future<int> deleteDiameter() async {
  //   final database = await DatabaseService().database;
  //   return await database.delete(tableDiameter);
  // }

  // Future<int> updateBacameter({
  //   required String cIdPel,
  //   required String dTglCatat,
  //   required int nStIni,
  //   required int nPakai,
  //   required String cKetWM,
  //   required String txtFoto,
  //   required String txtPathFoto,
  //   required String txtMemo,
  //   required int nEstimasi,
  // }) async {
  //   final database = await DatabaseService().database;
  //   return await database.update(
  //       tableBacameter,
  //       {
  //         'dTglCatat': dTglCatat,
  //         'nStIni': nStIni,
  //         'nPakai': nPakai,
  //         'cKetWM': cKetWM,
  //         'txtFoto': txtFoto,
  //         'txtPathFoto': txtPathFoto,
  //         'txtMemo': txtMemo,
  //         'nEstimasi': nEstimasi,
  //         'dTglUpload': null,
  //       },
  //       where: 'cIdPel = ?',
  //       whereArgs: [cIdPel]);
  // }

  // Future<int> updatePelangganUpload({
  //   required String cIdPel,
  // }) async {
  //   final database = await DatabaseService().database;
  //   return await database.update(
  //       tableBacameter,
  //       {
  //         'dTglUpload':
  //             DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
  //       },
  //       where: 'cIdPel = ?',
  //       whereArgs: [cIdPel]);
  // }
}
