import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_model.dart';
import 'todo_provider.dart'; // Import the provider

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cTitle = TextEditingController();
  TextEditingController cDesc = TextEditingController();
  List<Todo> todos = [];
  final todoProvider provider = todoProvider();

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Future<void> saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todosStringList =
        todos.map((todo) => '${todo.title}|${todo.desc}').toList();
    await prefs.setStringList('todos', todosStringList);
  }

  Future<void> loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todosStringList = prefs.getStringList('todos');
    if (todosStringList != null) {
      todos = todosStringList.map((todoString) {
        var parts = todoString.split('|');
        return Todo(
          title: parts[0],
          desc: parts[1],
        );
      }).toList();
    }
    setState(() {});
  }

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
                    editDialog(context, index);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    todos.remove(todos[index]);
                    saveTodos();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[900],
                        content: Text(
                          "Todo deleted successfully",
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
    cTitle.clear();
    cDesc.clear();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: cDesc,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            ElevatedButton(
                onPressed: () async {
                  var todo = Todo(title: cTitle.text, desc: cDesc.text);
                  todos.add(todo);
                  await saveTodos();
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green[900],
                      content: Text(
                        "Todo added successfully",
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

  Future<dynamic> editDialog(BuildContext context, int index) {
    cTitle.text = todos[index].title!;
    cDesc.text = todos[index].desc!;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: cDesc,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (cTitle.text != todos[index].title ||
                      cDesc.text != todos[index].desc) {
                    todos[index] = Todo(title: cTitle.text, desc: cDesc.text);
                    await saveTodos();
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green[900],
                        content: Text(
                          "Todo edited successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text('Save')),
          ],
        );
      },
    );
  }
}
