import 'package:flutter/material.dart';
import 'package:se_example/api.dart';
import 'package:se_example/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Todo>> todos;
  List<Todo> tododata;

  _MyHomePageState() {
    this.todos = APICalls.getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Todo>>(
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                if (tododata == null) {
                  tododata = snapshot.data;
                }
                List<Widget> todoWidgets =
                    tododata.map((todo) => getTodoContainer(todo)).toList();
                todoWidgets.insert(
                    0,
                    Container(
                      child: Text("Todo:",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      height: 50,
                    ));
                return ListView(
                  children: [Column(children: todoWidgets)],
                );
              }
              return CircularProgressIndicator();
            },
            future: todos));
  }

  Container getTodoContainer(Todo todo) {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(width: 1, style: BorderStyle.solid))),
        child: Row(children: [
          Text(todo.id.toString()),
          Expanded(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  var item =
                      tododata.firstWhere((element) => element.id == todo.id);
                  item.completed = !item.completed;
                });
              },
              child: Text(
                todo.title,
                softWrap: true,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                tododata.removeWhere((element) => element.id == todo.id);
              });
            },
            icon: Icon(Icons.delete_forever),
          ),
          todo.completed
              ? Icon(Icons.check, color: Colors.green)
              : Icon(Icons.clear, color: Colors.red)
        ]));
  }
}
