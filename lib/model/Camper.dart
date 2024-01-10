class Camper {
  int? id;
  String firstName;
  String birthday;

  Camper({this.id, required this.firstName, required this.birthday});

  Map<String, dynamic> toMap() {
    return {'id': id, 'firstName': firstName, 'birthday': birthday};
  }
}