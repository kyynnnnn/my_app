import 'package:flutter/material.dart';
import 'package:my_app/backend/create.dart';
import 'package:my_app/backend/crud.dart';
import 'package:my_app/backend/update.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Map<String, dynamic>>> dataFuture;

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is first created
    dataFuture = CrudService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter CRUD Example'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: CrudService.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                final item = data?[index];
                return ListTile(
                  title: Text('Nama: ' + item?['nama']),
                  subtitle: Text('Prodi: ' + item?['prodi']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      // Show confirmation dialog
                      bool confirmDelete = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Konfirmasi Hapus'),
                          content: Text(
                              'Apakah Anda yakin ingin menghapus data ini?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                      // Perform delete operation if confirmed
                      if (confirmDelete == true) {
                        await CrudService.deleteData(item?['nim']);
                        // Refresh data after deletion
                        setState(() {
                          dataFuture = CrudService.fetchData();
                        });
                      }
                    },
                  ),
                  onTap: () {
                    // Show update view when tapping on a list item
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateView(item),
                        // builder: (context) => Center(),
                      ),
                    ).then((_) => setState(() {
                          dataFuture = CrudService.fetchData();
                        }));
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Show add view
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Create(),
                  // builder: (context) => Center(),
                ),
              ).then((_) => setState(() {
                    dataFuture = CrudService.fetchData();
                  }));
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
