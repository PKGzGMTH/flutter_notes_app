class NoteModel {
  final int? id;
  final String title;
  final String description;

  NoteModel({this.id, required this.title, required this.description});

  NoteModel.formMap(Map<String, dynamic> item):
    id = item['id'],
    title = item['title'],
    description = item['description'];

  Map<String, Object?> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }
}
