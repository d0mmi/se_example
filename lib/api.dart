import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:se_example/todo.dart';

class APICalls {
  static Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    var response =
        await http.get("https://jsonplaceholder.typicode.com/todos/");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      todos = Todo.getTodos(json);
    }
    return todos;
  }
}
