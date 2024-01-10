class Camper {
  int? id;
  String name;
  String age;

  Camper({this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }
}