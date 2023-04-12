import 'package:transport/models/service.dart';

class OrderService {
  late int? id;
  late int amount;
  late Service service;
  OrderService(this.id, this.amount, this.service);

  OrderService.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    amount = map['amount'];
    service = Service.fromMap(map['additional_service']);
  }

  Map<String, dynamic> mapFromFields() {
    return {'amount': amount, 'additional_service': service.mapFromFields()};
  }
}
