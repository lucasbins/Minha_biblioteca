import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_flutter/Models/todo.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; //SINGLETON//PADRAO DE PROJETO
  static Database _database; // singleton database
  String todoTable = 'todo_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDesc = 'desc';
  String colDate = 'date';

  String colLido = 'lido';

  DatabaseHelper._createInstancia(); //Construtor nomeado.

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstancia();
    }
    return _databaseHelper;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'Create table $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDesc TEXT, $colDate Text, $colLido TEXT)');
    print('DB criado');
  }

  Future<Database> initializeDatabase() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String path = diretorio.path + "todo.db";
    var todoDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  //add
  Future<int> insertTodo(Todo todo) async {
    Database db = await this.database;
    var result = db.insert(todoTable, todo.toMap());
    return result;
  }

//update
  Future<int> updateTodo(Todo todo) async {
    Database db = await this.database;
    //  db.query("Update from todotable .............. where id=id")
    var result = db.update(todoTable, todo.toMap(),
        where: '$colId =?', whereArgs: [todo.id]);
    return result;
  }

//seleção maps
  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(todoTable, orderBy: '$colTitle ASC');
    return result;
  }

  Future<List<Todo>> getTodoList() async {
    var todoMapList = await getTodoMapList();
    // int count =todoMapList.length;
    int count = todoMapList.length;
    List<Todo> todoList = List<Todo>();
    for (int i = 0; i < count; i++) {
      todoList.add(Todo.fromMapObject(todoMapList[i]));
    }
    return todoList;
  }

//delete

  Future<int> deleteTodo(int id) async {
    Database db = await this.database;
    //  db.query("Update from todotable .............. where id=id")
    //var result=db.update(todoTable, todo.toMap(),where: '$colId =?',whereArgs: [todo.id] );
    ///  db.delete(table)
    ///  id = todo.id
    int result = await db.rawDelete('DELETE FROM $todoTable  WHERE $colId=$id');
    return result;
  }

//pegar total de linhas
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

//GETCOUNT2
  Future<List<Todo>> getCount2() async {
    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;
  }
}
