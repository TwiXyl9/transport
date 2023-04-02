class User {
  late int id;
  late String name;
  late String phone;

  User(this.id, this.name, this.phone);

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
  }

  Map<String, dynamic> mapFromFields() {
    return {'user':{'name': name, 'phone': phone}};
  }
}