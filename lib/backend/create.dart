import 'package:flutter/material.dart';
import 'package:my_app/backend/crud.dart';

class Create extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: prodiController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Add data and go back to the main screen
                await CrudService.addData(
                    namaController.text, prodiController.text);
                Navigator.pop(context);
              },
              child: Text('Add Data'),
            ),
          ],
        ),
      ),
    );
  }
}
