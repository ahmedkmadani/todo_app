import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = false;
  List items = [];
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                // final item = items[index] as Map;
                // final id = items['id'];
                return ListTile(
                  leading: CircleAvatar(child: Text("2")),
                  title: Text("Sample text"),
                  subtitle: Text("Sample text"),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'edit') {
                        // navigateToEditPage(item);
                      } else if (value == 'delete') {
                        // deleteByID(id);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text("Edit"),
                          value: 'edit',
                        ),
                        PopupMenuItem(
                          child: Text("Delete"),
                          value: 'delete',
                        ),
                      ];
                    },
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage, label: Text('Add Todo')),
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });

    fetchTodo();
  }

  void navigateToEditPage(Map item) {
    final route =
        MaterialPageRoute(builder: (context) => AddTodoPage(todo: item));
    Navigator.push(context, route);
  }

  Future<void> deleteByID(String id) async {
    final url = "";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      // flitered = items.where((element) => element['id'] != id).toList();
      setState(() {
        // items = flitered;
      });
    } else {
      showErrorMessage("Deletion Failed");
    }
  }

  Future<void> fetchTodo() async {
    setState(() {
      isLoading = false;
    });
    // final url = '';
    // final uri = Uri.parse(url);
    // final response = await http.get(uri);

    // if (response.statusCode == 200) {
    //   final json = jsonDecode(response.body) as Map;
    //   final result = json['items'];
    //   setState(() {
    //     items = result;
    //   });
    // } else {}
    // setState(() {
    //   isLoading = false;
    // });
  }

  void showSuccessMessage(msg) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
