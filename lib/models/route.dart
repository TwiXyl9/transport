import 'package:transport/models/point.dart';

class Route {
  late int? id;
  late Point start_point;
  late Point end_point;

  Route(this.id, this.start_point, this.end_point);

  Route.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    start_point = Point.fromMap(map['start_point']);
    end_point = Point.fromMap(map['end_point']);
  }

  Map<String, dynamic> mapFromFields() {
    return {'start_point': start_point.mapFromFields(), 'end_point': end_point.mapFromFields()};
  }
}
