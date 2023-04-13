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
  late String? stage;
  late Car car;
  late CargoType cargoType;
  late Route route;
  late List<OrderService> services = [];
  Order(this.id, this.name, this.phone, this.dateTime, this.stage, this.car, this.cargoType,this.route, this.services);

  Order.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    dateTime = map['date'];
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
      'stage': stage,
      'car': car.mapFromFields(),
      'route': route.mapFromFields(),
      'order_additional_services_attributes': services.map((e) => e.mapFromFields()).toList()
    };
  }
  Map<String, dynamic> shortMapFromFields() {
    return {
      'name': name,
      'phone': phone,
      'date': dateTime,
      'car_id': car.id,
      'cargo_type_id': cargoType.id,
      'route': route.mapFromFields(),
      'order_additional_services_attributes': services.map((e) => e.mapFromFields()).toList()
    };
  }
}