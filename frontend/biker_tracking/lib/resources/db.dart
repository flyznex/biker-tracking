import 'dart:io';

import 'package:uuid/uuid.dart';

import '../models/vehicle.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider._();
  static final DbProvider db = DbProvider._();

  Database _database;

  Future<Database> get database async {
    if (database != null) return this._database;
    this._database = initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'vehicle.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      final String sql = "CREATE TABLE vehicle ("
          "id VARCHAR(200) PRIMARY KEY,"
          "name VARCHAR(200),"
          "current_odo NUMERIC,"
          "created_at DATETIME,"
          "updated_at DATETIME,"
          "favorite BOOLEAN"
          ");"
          "CREATE TABLE vehicleHistory ("
          "id VARCHAR(200) PRIMARY KEY,"
          "vehicle_id VARCHAR(200),"
          "action VARCHAR(200),"
          "description TEXT,"
          "action_at DATETIME,"
          "created_at DATETIME,"
          "updated_at DATETIME,"
          ");";
      await db.execute(sql);
    });
  }

  insertVehicle(VehicleModel vhm) async {
    final db = await database;
    final sql =
        "INSERT INTO vehicle (id, name, current_odo, created_at, updated_at,favorite)"
        "VALUES (?, ?, ?, ?, ?, ?)";
    vhm.id = Uuid().v4();
    final now = new DateTime.now();
    vhm.createdAt = now;
    vhm.updatedAt = now;
    var raw = await db.rawInsert(sql, [
      vhm.id,
      vhm.name,
      vhm.currentODO,
      vhm.createdAt,
      vhm.updatedAt,
      vhm.favorite
    ]);
    return raw;
  }
  updateVehicle(VehicleModel vhm) async {
    final db = await database;
    vhm.updatedAt = new DateTime.now();
    var res = await db.update("vehicle",vhm.toMap(),where: "id = ?",whereArgs: [vhm.id]);
  }
}
