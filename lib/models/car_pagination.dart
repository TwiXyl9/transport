import 'package:transport/models/car.dart';

class CarsPagination {
  late int count;
  late String prev_url;
  late String next_url;
  late int page;
  late List<Car> cars;
  CarsPagination.fromMap(Map<String, dynamic> map) {
    count = map['pagy']['count'];
    prev_url = map['pagy']['prev_url'];
    next_url = map['pagy']['next_url'];
    page = map['pagy']['page'];
    cars = List<Car>.from(map['data'].map((car) => Car.fromMap(car)).toList());
  }
}