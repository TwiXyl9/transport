class Capacity {
  late int id;
  late double width;
  late double height;
  late double length;
  late int numOfPallets;
  late double loadCapacity;

  Capacity(this.id, this.width, this.height, this.length, this.numOfPallets, this.loadCapacity);

  Capacity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    width = map['width'];
    height = map['height'];
    length = map['length'];
    numOfPallets = map['num_of_pallets'];
    loadCapacity = map['load_capacity'];
  }

  Map<String, dynamic> mapFromFields() {
    return {'id': id, 'width': width, 'height': height, 'length': length, 'num_of_pallets': numOfPallets, 'load_capacity': loadCapacity};
  }

  Map<String, String> namedMapFromFields() {
    return {
      'capacity[width]': width.toString(),
      'capacity[height]': height.toString(),
      'capacity[length]': length.toString(),
      'capacity[num_of_pallets]': numOfPallets.toString(),
      'capacity[load_capacity]': loadCapacity.toString(),
    };
  }
}
