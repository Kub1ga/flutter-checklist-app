import 'package:checklist_app/config/api_services.dart';
import 'package:checklist_app/models/checklist.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Checklist> _checklists = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchChecklists();
  }

  Future<void> _fetchChecklists() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final checklists = await ApiService().getAllChecklists();
      setState(() {
        _checklists = checklists;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching checklists: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addchecklist');
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildChecklistsList(),
    );
  }

  Widget _buildChecklistsList() {
    return ListView.builder(
      itemCount: _checklists.length,
      itemBuilder: (context, index) {
        final checklist = _checklists[index];
        return ListTile(
          title: Text(checklist.name),
        );
      },
    );
  }
}
