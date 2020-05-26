class Todo {
  int userId;
  int id;
  String title;
  bool completed;

  Todo(this.userId, this.id, this.title, this.completed);

  factory Todo.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Todo(json["userId"], json["id"], json["title"], json["completed"]);
  }

  static List<Todo> getTodos(List<dynamic> json) {
    List<Todo> todos = [];
    for (var entry in json) {
      todos.add(Todo.fromJson(entry));
    }
    return todos;
  }
}
