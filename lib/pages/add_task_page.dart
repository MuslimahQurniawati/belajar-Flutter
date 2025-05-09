import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Tugas')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Nama Tugas'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () {
                final task = taskController.text.trim;
                // Belum ada fungsi simpan - kita akan buat nanti
                Navigator.pop(context, task);
              },
            ),
          ],
        ),
      ),
    );
  }
}
