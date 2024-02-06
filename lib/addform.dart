import 'package:flutter/material.dart';
import 'package:flutter_sqflite_homework/database.dart';
import 'package:flutter_sqflite_homework/model.dart';

class addForm extends StatefulWidget {
  @override
  State<addForm> createState() => _addFormState();
}

class _addFormState extends State<addForm> {
  AppDatabase db = AppDatabase();

  final titleControllor = TextEditingController();
  final descriptionControllor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(39, 45, 47, 1),
        title: Center(
          child: Text(
            'iNotes',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                Text(
                  'Add your new Note!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  autofocus: true,
                  controller: titleControllor,
                  decoration: InputDecoration(
                    hintText: 'Add a Title',
                    icon: Icon(Icons.title),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  maxLines: 3,
                  controller: descriptionControllor,
                  decoration: InputDecoration(
                    hintText: 'Add a Description',
                    icon: Icon(Icons.description),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Map input = {
                      'title':titleControllor.text,
                      'description': descriptionControllor.text
                      };
                    insert(input);
                  },
                  child: Text('Add Note!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void insert(Map input) async {
    NoteModel data = NoteModel(
      title: input['title'],
      description: input['description']
    );
    await db.insertData(data);
  }
}
