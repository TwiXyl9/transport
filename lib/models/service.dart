import 'package:http/http.dart';

class Service {
  late int id;
  late String name;
  late double price;
  late String imageUrl;
  late MultipartFile imageFile;

  Service(this.id);
  Service.fromData(this.id, this.name, this.price, this.imageUrl);
  Service.withFile(this.id, this.name, this.price, this.imageFile);
  Service.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    imageUrl = map['image_url'];
  }

  Map<String, String> mapFromFields() {
    return {'service[name]': name, 'service[price]': price.toString()};
  }
}
