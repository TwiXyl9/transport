import 'dart:convert';

import 'package:transport/models/cargo_type.dart';
import 'package:transport/models/route.dart';
import 'package:transport/models/user.dart';

import 'car.dart';
import 'order_service.dart';

class Order {
  late int? id;
  late User? user;
  late String name;
  late String phone;
  late String dateTime;
  late double totalPrice;
  late String? stage;
  late Car car;
  late CargoType cargoType;
  late Route route;
  late List<OrderService> services = [];
  Order(this.id, this.name, this.phone, this.dateTime, this.stage, this.totalPrice, this.car, this.cargoType,this.route, this.services, this.user);

  Order.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    dateTime = map['date'];
    totalPrice = map['total_price'];
    stage = map['stage'];
    car = Car.fromMap(map['car']);
    cargoType = CargoType.fromMap(map['cargo_type']);
    route = Route.fromMap(map['route']);
    List<dynamic> servicesMap = map['order_additional_services'];
    if(servicesMap.length > 0){
      services = servicesMap.map((service) => OrderService.fromMap(service)).toList();
    }

  }

  Map<String, dynamic> mapFromFields() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'date': dateTime,
      'total_price': totalPrice,
      'stage': stage,
      'car': car.mapFromFields(),
      'route': route.mapFromFields(),
      'order_additional_services_attributes': services.map((e) => e.shortMapFromFields()).toList()
    };
  }
  Map<String, dynamic> shortMapFromFields() {
    return {
      'order': {
        'name': name,
        'phone': phone,
        'date': dateTime,
        'total_price': totalPrice,
        'car_id': car.id,
        'cargo_type_id': cargoType.id,
        if (user!.id! > 0) 'user_id': user!.id,
        'route': route.mapFromFields(),
        'order_additional_services_attributes': services.map((e) => e.shortMapFromFields()).toList()
      }
    };
  }
}
