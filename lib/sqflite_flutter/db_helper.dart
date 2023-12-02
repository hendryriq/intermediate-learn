import 'package:intermediate_learn/sqflite_flutter/model_pegawai.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  final String tabelPegawai = "tbPegawai";
  final String columnId = "id";
  final String columnFirstName = "firstname";
  final String columnLastName = "lastname";
  final String columnMobileNo = "mobileno";
  final String columnEmailId = "emailid";

  Database? db;
  Future<Database?> cekDatabase() async{
    if(db != null){
      return db;
    }
    db = await initDb();
    return db;
  }

  Future initDb() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "pegawai.db");

    var db = openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  Future<void> onCreate(Database db, int newVersion) async{
    await db.execute(
      "CREATE TABLE $tabelPegawai($columnId INTEGER PRIMARY KEY, $columnFirstName TEXT, $columnLastName TEXT, $columnMobileNo TEXT, $columnEmailId TEXT)");
  }

  Future<int?> saveData(ModelPegawai pegawai) async{
    var dbClient = await cekDatabase();
    var result = dbClient!.insert(tabelPegawai, pegawai.toMap());
    if(kDebugMode){
      print("insert data $result");
    }
    return result;
  }
  
  Future<List?> getAllpegawai() async{
    var dbClient = await cekDatabase();
    var result = await dbClient!.query(tabelPegawai, columns: [
      columnId,
      columnFirstName,
      columnLastName,
      columnMobileNo,
      columnEmailId,
    ]);
    if (kDebugMode){
      print("show data $result");
    }
    return result;
  }

  Future<int?> updatePegawai(ModelPegawai pegawai) async{
    var dbClient = await cekDatabase();
    var result = await dbClient!.update(tabelPegawai, pegawai.toMap(),
    where: "$columnId = ?", whereArgs: [pegawai.id]);
    return result;
  }
  Future<int?> deletePegawai(int id) async{
    var dbClient = await cekDatabase();
    var result = await dbClient!
        .delete(tabelPegawai, where: "$columnId = ?", whereArgs: [id]);
    return result;
  }

}