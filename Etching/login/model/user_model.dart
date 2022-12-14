class Todo {
  final int? id;
  final String? name;
  final String? email;
  static const String TABLENAME = "etching";

  Todo({this.id, this.name, this.email});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }
}