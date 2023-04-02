class News {
  late int id;
  late String title;
  late String description;
  late String image;

  News(this.id, this.title, this.description, this.image);

  News.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    image = map['image'];
  }

  Map<String, dynamic> mapFromFields() {
    return {'news':{'title': title, 'description': description, 'image': image}};
  }
}
