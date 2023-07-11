import 'package:transport/models/service.dart';

class ServicesPagination {
  late int count;
  late String prev_url;
  late String next_url;
  late int page;
  late List<Service> services;
  ServicesPagination.fromMap(Map<String, dynamic> map) {
    count = map['pagy']['count'];
    prev_url = map['pagy']['prev_url'];
    next_url = map['pagy']['next_url'];
    page = map['pagy']['page'];
    services = List<Service>.from(map['data'].map((car) => Service.fromMap(car)).toList());
  }
}