import 'package:http/http.dart';
import 'package:transport/models/capacity.dart';
import 'package:transport/models/tail_type.dart';

class Car {
  late int? id;
  late String brand;
  late String model;
  late double price;
  late List<String> imagesUrls;
  late List<MultipartFile> imagesFiles;
  late Capacity capacity;
  late TailType tailType;
  Car(this.id);
  Car.fromData(this.id, this.brand, this.model, this.price, this.imagesUrls);
  Car.withFiles(this.id, this.brand, this.model, this.price, this.imagesFiles, this.capacity, this.tailType);
  Car.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    brand = map['brand'];
    model = map['model'];
    price = map['price'];
    imagesUrls = List<String>.from(map['images_url'] as List);
    capacity = Capacity.fromMap(map['capacity']);
    tailType = TailType.fromMap(map['tail_type']);
  }
  Map<String, dynamic> mapFromFields() {
    return {'brand': brand, 'model': model, 'price': price};
  }
  Map<String, String> namedMapFromFields() {
    return {
      'car[brand]': brand,
      'car[model]': model,
      'car[price]': price.toString(),
      'car[tail_type_id]': tailType.id.toString(),
    };
  }

}