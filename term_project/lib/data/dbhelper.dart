import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../models/Student.dart';

class DbHelper {
  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb(); //databsase yoksa bir db oluştur
    }
    return _db!;
  }

  Future<Database> initializeDb() async {
    String dbPath = await getDatabasesPath(); //veritabanının yolunu verir
    var mypath = join(dbPath,
        'attendanceDB.db'); //veritabanını yolunda olusturulan dbyi birleştiriyor
    //burada verilen dbPath'teki db açılır, eğer db yoksa onCreate ile db olusturulur

    var attendanceDB = await openDatabase(
      mypath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE Students (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT ,password TEXT)");
      },
    );
    return attendanceDB;
  }

  Future<List<Student>> getStudents() async {
    Database db = await this.db;

    var result = await db.query(
        "students"); //query içerisine tablo adını alır ve burada tüm kayıtları döndürüyor.
    return result.map<Student>(
      (e) {
        return Student.fromJsonObject(e);
      },
    ).toList();
  }

  //veritabanında değişiklik yapan sorgular yazdıgınızda o tabloda kaç kayıt etkileniyorsa onu döndürür o sebeple int deger donduren bir fonksiyon yazdık
  Future<int> insert(Student student) async {
    Database db = await this.db;

    var result = await db.insert("Students", student.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;

    var result = await db.rawDelete("delete from Students where id = $id");
    return result;
  }

  Future<int> update(Student student) async {
    Database db = await this.db;

    var result = db.update("Students", student.toMap(),
        where: "id=?", whereArgs: [student.id]);
    return result;
  }

  Future<bool> entryControl(Student student) async {
    Database db = await this.db;

    try {
      var jsonObject = (await db.rawQuery(
          "select * from Students where username = ${student.username} and password = ${student.password}"));

      if (jsonObject.length == 1) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
