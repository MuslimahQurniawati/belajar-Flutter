import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _tasks = [];

  void _navigateToAddTask() async {
    final newTask = await Navigator.pushNamed(context, '/add');
    if (newTask != null && newTask is String) {
      setState(() {
        _tasks.add(newTask);
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Quicksand-VariableFont_wght',
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Quicksand-VariableFont_wght',
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text(
                'Tambah Tugas',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Quicksand-VariableFont_wght',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateToAddTask();
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                'Tentang Aplikasi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Quicksand-VariableFont_wght',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body:
          _tasks.isEmpty
              ? Center(child: Text('Belum ada Tugas'))
              : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_tasks[index]));
                },
              ),
    );
  }
}
