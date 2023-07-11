class Point {
  late int id;
  late String placeId;
  late double latitude;
  late double longitude;
  late String address;

  Point(this.id, this.latitude, this.longitude, this.address, this.placeId);

  Point.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    address = map['address'];
    placeId = map['placeId'];
  }

  Map<String, dynamic> mapFromFields() {
    return {'latitude': latitude, 'longitude': longitude, 'address': address, 'placeId': placeId};
  }
}
