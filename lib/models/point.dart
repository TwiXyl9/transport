class Point {
  late int id;
  late double latitude;
  late double longitude;
  late String address;

  Point(this.id, this.latitude, this.longitude, this.address);

  Point.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    address = map['address'];
  }

  Map<String, dynamic> mapFromFields() {
    return {'id': id, 'latitude': latitude, 'longitude': longitude, 'address': address};
  }
}
