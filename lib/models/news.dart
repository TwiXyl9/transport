import 'package:http/http.dart';

class News {
  late int id;
  late String title;
  late String description;
  late String imageUrl;
  late MultipartFile imageFile;

  News(this.id, this.title, this.description, this.imageUrl);
  News.withFile(this.id, this.title, this.description, this.imageFile);

  News.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    imageUrl = map['image_url'];
  }

  Map<String, String> mapFromFields(){
    return {'news[title]': title, 'news[description]': description};
  }
}
