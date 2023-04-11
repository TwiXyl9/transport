class CargoType {
  late int id;
  late String name;

  CargoType(this.id, this.name);

  CargoType.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  Map<String, dynamic> mapFromFields() {
    return {'cargo_type':{'id' : id, 'name': name,}};
  }
}
