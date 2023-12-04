import 'package:flutter/material.dart';
import 'package:my_app/backend/crud.dart';

class UpdateView extends StatefulWidget {
  final Map<String, dynamic>? data;

  UpdateView(this.data);

  @override
  _UpdateViewState createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  late TextEditingController namaController;
  late TextEditingController prodiController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.data?['nama']);
    prodiController = TextEditingController(text: widget.data?['prodi']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
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
                print('Updating data...');
                print('nim: ${widget.data?['nim']}');
                print('Nama: ${namaController.text}');
                print('Prodi: ${prodiController.text}');
                // Update data and go back to the main screen
                await CrudService.updateData(
                  widget.data?['nim'],
                  namaController.text,
                  prodiController.text,
                );
                Navigator.pop(context);
                ;
              },
              child: Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
