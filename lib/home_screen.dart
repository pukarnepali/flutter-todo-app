import 'package:flutter/material.dart';

import 'todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cTitle = TextEditingController();
  TextEditingController cDesc = TextEditingController();
  List<Todo> todos = [
    Todo(title: "Attend Class", desc: "Attend class at 5:30 pm"),
    Todo(title: "Attend Class", desc: "Attend class at 5:30 pm"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            'Todo App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title!),
            subtitle: Text(todos[index].desc!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    todos.remove(todos[index]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[900],
                        content: Text(
                          "Todo edited succesfully",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                    setState(() {});
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    todos.remove(todos[index]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[900],
                        content: Text(
                          "Todo deleted succesfully",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                    setState(() {});
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> addDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (conetxt) {
          return AlertDialog(
            title: Text("Add Todo"),
            content: Column(
              children: [
                TextField(
                  controller: cTitle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                    controller: cDesc,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    )),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var todo = Todo(title: cTitle.text, desc: cDesc.text);
                    todos.add(todo);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green[900],
                        content: Text(
                          "Todo added succesfully",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Add')),
            ],
          );
        });
  }

  Future<dynamic> updateDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (conetxt) {
        return AlertDialog(
          title: Text("Add Todo"),
          content: Column(
            children: [
              TextField(
                controller: cTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                  controller: cDesc,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  )),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  var todo = Todo(title: cTitle.text, desc: cDesc.text);
                  todos.add(todo);
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green[900],
                      content: Text(
                        "Todo added succesfully",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text('Add')),
          ],
        );
      },
    );
  }
}
// to be continued