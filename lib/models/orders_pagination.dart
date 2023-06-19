import 'package:transport/models/order.dart';

class OrdersPagination {
  late int count;
  late String prev_url;
  late String next_url;
  late int page;
  late List<Order> orders;
  OrdersPagination.fromMap(Map<String, dynamic> map) {
    count = map['pagy']['count'];
    prev_url = map['pagy']['prev_url'];
    next_url = map['pagy']['next_url'];
    page = map['pagy']['page'];
    orders = List<Order>.from(map['data'].map((order) => Order.fromMap(order)).toList());
  }
}