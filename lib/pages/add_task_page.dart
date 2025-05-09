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
              onPressed: () {
                final taskText = taskController.text.trim();
                if (taskText.isNotEmpty) {
                  Navigator.pop(context, taskText); // Kirim data kembali
                }
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
