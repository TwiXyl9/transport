class Car {
  late int id;
  late String brand;
  late String model;
  late double price;
  late List<String> images;
  late double width;
  late double height;
  late double length;
  late int numOfPallets;
  late double loadCapacity;
  late String tailType;

  Car(this.id, this.brand, this.model, this.price, this.images, this.width, this.height, this.length, this.numOfPallets,this.tailType);

  Car.fromMap(Map<String, dynamic> map) {
    id = map['car']['id'];
    brand = map['car']['brand'];
    model = map['car']['model'];
    price = map['car']['price'];
    images = List<String>.from(map['car']['images'] as List);
    width = map['car']['width'];
    height = map['car']['height'];
    length = map['car']['length'];
    numOfPallets = map['car']['num_of_pallets'];
    loadCapacity = map['car']['load_capacity'];
    tailType = map['car']['tail_type'];
  }

  Map<String, dynamic> mapFromFields() {
    return {
      'car': {
        'brand': brand, 'model': model, 'tail_type_id': tailType, 'images': images
      },
      'capacity': {
        'width': width, 'height': height, 'length': length, 'num_of_pallets': numOfPallets
      }
    };
  }
}