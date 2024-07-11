import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body : ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Judul'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Deskripsi'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: submitData, child: Text('Submit'))
        ]
      )
    );
  }

  Future<void> submitData() async {
      final title = titleController.text;
      final description = descriptionController.text;
      final body = {
        "title" : title,
        "description" : description,
        "is_completed": false,
      };
   
  final url = 'http://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  final response = await http.post(
    uri, 
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
    );

  if(response.statusCode == 201){
    print('Berhasil ditambahkan');
    showSuccessMessage('Berhasil ditambahkan');
  }else{
    print(response.body);
    print('Gagal menambahkan data');
    showErrorMessage('Gagal Menambahkan data');
    
  }

  }

  void showSuccessMessage(String message){
    titleController.text = '';
    descriptionController.text='';
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  
  void showErrorMessage(String message){
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle( color: Colors.white),
        ),
      backgroundColor: Colors.red,
      );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



 
}