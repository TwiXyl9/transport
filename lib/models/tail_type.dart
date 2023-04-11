class TailType {
  late int id;
  late String name;

  TailType(this.id, this.name);

  TailType.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  Map<String, dynamic> mapFromFields() {
    return {'id': id, 'name': name};
  }
}
