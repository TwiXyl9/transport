import 'package:transport/models/service.dart';

class OrderService {
  late int? id;
  late int amount;
  late Service service;
  OrderService(this.id, this.amount, this.service);

  OrderService.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    amount = map['amount'];
    service = Service.fromMapWithoutImage(map['additional_service']);
  }
  Map<String, int> shortMapFromFields() {
    return {
      if (id != null && id! > 0) 'id' : id!,
      'amount': amount,
      'additional_service_id': service.id
    };
  }
  Map<String, dynamic> mapFromFields() {
    return {'amount': amount, 'additional_service': service.mapFromFields()};
  }

  bool operator ==(Object other) => other is OrderService && other.id == id;
}
