import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:todo_list_flutter/Models/todo.dart';
import 'package:todo_list_flutter/Pages/todo_detail.dart';
import 'package:todo_list_flutter/Utils/database_helper.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList = List<Todo>();

  @override
  void initState() {
    super.initState();
    updateListView();
    debugPrint(todoList.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Biblioteca'),
      ),
      body: getTodosListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Adicionar');
          navigateToDetail(Todo('', '', '', ''), 'Adicionar');
        },
        tooltip: 'Adicionara Livro',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getTodosListView() {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (BuildContext context, int position) {
        Todo todo = todoList[position];
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(getAvatar(todo.title),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title:
                Text(todo.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(todo.autor),
            trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.blueAccent,
                ),
                onTap: () {
                  _delete(context, todo);
                }),
            onTap: () {
              print("Lista detalhes");
              navigateToDetail(todo, todo.title);

              //faça o navigate
            },
          ),
        );
      },
    );
  }

  getAvatar(String title) {
    if (title.length < 2) {
      return '';
    } else {
      return title.substring(0, 2);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Todo todo, String title) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
      debugPrint("Chamou a segunda tela");

      //return TodoDetail(todo, title);
    })).then((result) {
      if (result ?? true) {
        updateListView();
      }
    });
  }

  void _delete(BuildContext ctx, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(ctx, "Deletando...");
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
        });
      });
    });
  }
}
