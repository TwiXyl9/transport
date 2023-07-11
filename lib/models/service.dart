import 'package:http/http.dart';

class Service {
  late int id;
  late String name;
  late double price;
  late String description;
  late String imageUrl;
  late MultipartFile imageFile;

  Service(this.id);
  Service.fromData(this.id, this.name, this.description, this.price, this.imageUrl);
  Service.withFile(this.id, this.name, this.description, this.price, this.imageFile);
  Service.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    description = map['description'];
    imageUrl = map['image_url'];
  }
  Service.fromMapWithoutImage(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    description = map['description'];
  }

  Map<String, String> mapFromFields() {
    return {'service[name]': name, 'service[price]': price.toString(), 'service[description]': description};
  }
  bool operator ==(Object other) => other is Service && other.id == id;
}
