class TailType {
  late int id;
  late String name;

  TailType(this.id, this.name);

  bool operator ==(Object other) => other is TailType && other.id == id;

  TailType.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  Map<String, dynamic> mapFromFields() {
    return {'id': id, 'name': name};
  }
}
