import 'package:flutter/material.dart';
import '../../data/local_storage/hive_storage.dart';
import '../../data/models/inspiration_model.dart';

class InspirationWallPage extends StatefulWidget {
  @override
  _InspirationWallPageState createState() => _InspirationWallPageState();
}

class _InspirationWallPageState extends State<InspirationWallPage> {
  List<InspirationModel> _wall = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInspirationWall();
  }

  Future<void> _loadInspirationWall() async {
    final inspirations = await HiveStorage.getAllInspirations();
    setState(() {
      _wall = inspirations;
    });
  }

  Future<void> _addInspiration(String text) async {
    final inspiration = InspirationModel(
      text: text,
      date: DateTime.now(),
    );
    await HiveStorage.saveInspiration(inspiration);
    _loadInspirationWall(); // Reload the list
  }

  Future<void> _deleteInspiration(InspirationModel inspiration) async {
    await HiveStorage.deleteInspiration(inspiration);
    _loadInspirationWall(); // Reload the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inspiration Wall",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Add a new inspiration or quote...",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  _addInspiration(text);
                  _textController.clear();
                }
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _wall.length,
                itemBuilder: (context, index) {
                  final inspiration = _wall[index];
                  return Card(
                    child: ListTile(
                      title: Text(inspiration.text),
                      subtitle: Text(inspiration.date.toLocal().toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteInspiration(inspiration),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
