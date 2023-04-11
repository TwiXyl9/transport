class Service {
  late int id;
  late String name;
  late double price;
  late String? errorMsg;
  Service(this.id, this.name, this.price);

  Service.fromMap(Map<String, dynamic> map) {
    if (map['errors'] != null){
      errorMsg = map['errors'][0][0];
      print(errorMsg);
    } else{
      errorMsg = null;
      id = map['id'];
      name = map['name'];
      price = map['price'];
    }

  }

  Map<String, dynamic> mapFromFields() {
    return {'service':{'id': id, 'name': name, 'price': price}};
  }
}
