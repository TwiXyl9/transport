import 'package:transport/models/capacity.dart';
import 'package:transport/models/tail_type.dart';

class Car {
  late int? id;
  late String brand;
  late String model;
  late double price;
  late List<String> images;
  late Capacity capacity;
  late TailType tailType;
  Car(this.id);
  Car.fromData(this.id, this.brand, this.model, this.price, this.images);
  Car.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    brand = map['brand'];
    model = map['model'];
    price = map['price'];
    images = List<String>.from(map['images_url'] as List);
    capacity = Capacity.fromMap(map['capacity']);
    tailType = TailType.fromMap(map['tail_type']);
  }

  Map<String, dynamic> mapFromFields() {
    return {'brand': brand, 'model': model, 'price': price};
  }
}