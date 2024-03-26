import 'package:checklist_app/config/api_services.dart';
import 'package:flutter/material.dart';

class AddChecklistPage extends StatefulWidget {
  @override
  _AddChecklistPageState createState() => _AddChecklistPageState();
}

class _AddChecklistPageState extends State<AddChecklistPage> {
  final TextEditingController _nameController = TextEditingController();
  final ApiService apiService = ApiService();
  final String token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Checklist'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Checklist Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _tambahChecklist();
              },
              child: Text('Add Checklist'),
            ),
          ],
        ),
      ),
    );
  }

  void _tambahChecklist() {
    final String name = _nameController.text.trim();
    if (name.isNotEmpty) {
      ApiService().addChecklist(name);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Berhasil Menambahkan.'),
      ));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter checklist name.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
