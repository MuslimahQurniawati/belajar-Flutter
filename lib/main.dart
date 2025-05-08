import 'package:flutter/material.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List Sederhana',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: ToDoHomePage(),
    );
  }
}

class ToDoHomePage extends StatefulWidget {
  @override
  _ToDoHomePageState createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  void _addTask() {
    String text = _taskController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add({'text': text, 'isDone': false});
        _taskController.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks =
        _tasks.where((task) {
          return task['text'].toLowerCase().contains(_searchQuery);
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(fontFamily: 'Quicksand-VariableFont_wght'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari tugas...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Tambah tugas...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _addTask, child: Text('Tambah')),
              ],
            ),
          ),
          Expanded(
            child:
                filteredTasks.isEmpty
                    ? Center(child: Text('Tidak ada tugas yang cocok.'))
                    : ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        final originalIndex = _tasks.indexWhere(
                          (t) => t['text'] == task['text'],
                        );

                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: task['isDone'],
                              onChanged: (_) => _toggleTask(originalIndex),
                            ),
                            title: Text(
                              task['text'],
                              style: TextStyle(
                                decoration:
                                    task['isDone']
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                color:
                                    task['isDone'] ? Colors.grey : Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(originalIndex),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
