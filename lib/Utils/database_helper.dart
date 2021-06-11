import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_flutter/Models/todo.dart';
class DatabaseHelper {
  static DatabaseHelper _databaseHelper; //SINGLETON
  static Database _database; // singleton database


  String todoTable = 'todo_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDesc = 'desc';
  String colDate = 'date';

  DatabaseHelper._createInstancia(); //Construtor nomeado.

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstancia();
    }
    return _databaseHelper;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'Create table $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
            '$colDesc TEXT, $colDate Text)');
  }

}