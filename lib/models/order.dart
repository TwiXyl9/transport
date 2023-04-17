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
// {"name"=>"Иван",
// "phone"=>"80291234567",
// "date"=>"25.04.23, 16:56",
// "car_id"=>2, "cargo_type_id"=>2,
// "user_id"=>1,
// "route"=>{"id"=>0, "start_point"=>{"latitude"=>54.3, "longitude"=>43.3, "address"=>"address1"},
//                    "end_point"=>{"latitude"=>55.3, "longitude"=>45.3, "address"=>"address2"}},
// "order_additional_services_attributes"=>[
// {"amount"=>5, "additional_service_id"=>1},
// {"amount"=>1, "additional_service_id"=>2},
// {"amount"=>1, "additional_service_id"=>3}],
// "order"=>{"phone"=>"80291234567", "name"=>"Иван", "date"=>"25.04.23, 16:56", "car_id"=>2, "user_id"=>1, "cargo_type_id"=>2}}




// {"order"=>{
// "name"=>"Иван",
// "phone"=>"80291234567",
// "date"=>"07.04.2023, 13:30",
// "car_id"=>"1",
// "cargo_type_id"=>"1",
// "order_additional_services_attributes"=>[
// {"amount"=>"3", "additional_service_id"=>"1"},
// {"amount"=>"4", "additional_service_id"=>"2"}]},
// "route"=>{"start_point"=>{"latitude"=>"53.3", "longitude"=>"27.4", "address"=>"Lenina 20"},
// "end_point"=>{"latitude"=>"55.4", "longitude"=>"34.5", "address"=>"Ozeshko 22"}}}
