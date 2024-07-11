import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:uas_novia/screens/add_page.dart';
import 'package:uas_novia/screens/list.dart';
import 'package:http/http.dart' as http;

class TodoListpage extends StatefulWidget {
  const TodoListpage({super.key});

  @override
  State<TodoListpage> createState() => _TodoListpageState();
}

class _TodoListpageState extends State<TodoListpage> {
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  bool is_loading = true;
  List toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // centerTitle: true,
        title: const Text(
          'MytoDo',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
      ),
      body: Visibility(
        visible: is_loading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (BuildContext context, index) {
              final item = toDoList[index] as Map;
              final id = item['_id'];
              final title = item['title'];
              final description = item['description'];
              final isCompleted = item['is_completed'];
              return TodoList(
                taskName: title,
                description: description,
                taskCompleted: isCompleted,
                onChanged: (value) => checkBoxChanged(title,description,id,isCompleted),
                deleteFunction: (contex) => deleteTask(id),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateTopage,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchTodo() async {
    setState(() {
      is_loading = true;
    });

    final url = 'http://api.nstack.in/v1/todos?page=1&limit=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['items'] as List;
      setState(() {
        toDoList = result;
      });
    }
    setState(() {
      is_loading = false;
    });
  }

  Future<void> navigateTopage() async {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      is_loading = true;
    });
    fetchTodo();
  }

  Future<void> checkBoxChanged(String title, String description, String id, bool is_completed) async {
    final body = {
      "title" : title,
      "description" : description,
      "is_completed" : !is_completed,
    };

    final url = 'http://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},

    );

     if(response.statusCode==200){
        final filtered = toDoList.where((element) => element['_id'] != id).toList();
        setState(() {
          toDoList = filtered;
        });
        fetchTodo();
      }
  }

  // 
  
  Future<void> deleteTask(String id) async {
      final url = 'http://api.nstack.in/v1/todos/$id';
      final uri = Uri.parse(url);
      final response = await  http.delete(uri);

      if(response.statusCode==200){
        final filtered = toDoList.where((element) => element['_id'] != id).toList();
        setState(() {
          toDoList = filtered;
        });
      }
  }
}
