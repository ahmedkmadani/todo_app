import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Todo" : "Add Todo"),
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(hintText: 'Title'),
        ),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(hintText: 'Description'),
          keyboardType: TextInputType.multiline,
          minLines: 4,
          maxLines: 8,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: isEdit ? updateDate : submitData,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(isEdit ? "Update" : "Submit"),
          ),
        )
      ]),
    );
  }

  Future<void> updateDate() async {
    final todo = widget.todo;
    if (todo == null) {
      return;
    }
    final id = todo['id'];
    final isCompleted = todo['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {};
    final url = "";
    final uri = Uri.parse(url);

    final res = await http.post(uri, body: body, headers: {});

    if (res.statusCode == 201) {
      titleController.text = "";
      descriptionController.text = "";
      showSuccessMessage("Creation Success");
    } else {
      showErrorMessage("Creation Failed");
    }
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {};
    final url = "";
    final uri = Uri.parse(url);

    final res = await http.post(uri, body: body, headers: {});

    if (res.statusCode == 201) {
      titleController.text = "";
      descriptionController.text = "";
      showSuccessMessage("Creation Success");
    } else {
      showErrorMessage("Creation Failed");
    }
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
