class Service {
  late int id;
  late String name;
  late double price;

  Service(this.id, this.name, this.price);

  Service.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
  }

  Map<String, dynamic> mapFromFields() {
    return {'service':{'name': name, 'price': price}};
  }
}
