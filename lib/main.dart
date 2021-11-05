import 'package:flutter/material.dart';
import 'Pages/todo_list.dart';

void main() {
  runApp(AppTodo());
}

class AppTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Biblioteca",
      //  debugShowCheckedModeBanner: false,
      home: TodoList(),
    );
  }
}
