import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:transport/requests/requests_paths_names.dart';

import '../../models/news.dart';
import '../../services/api_service.dart';

class NewsSlider extends StatelessWidget {
  NewsSlider({super.key});
  ApiService crud = ApiService();
  List<CarouselItem> newsToCarouselItem(allNews) {
    List<CarouselItem> itemList = [];
    for (var i = 0; i < allNews.length; i++) {
      itemList.add(CarouselItem(
        image: NetworkImage(
          allNews[i].image,
        ),
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
            colors: [
              Colors.blueAccent.withOpacity(1),
              Colors.black.withOpacity(.3),
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        title: allNews[i].title + '\n \n' + allNews[i].description,
        titleTextStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        onImageTap: (i) {},
      ));
    }
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
      future: crud.newsIndexRequest(newsPath),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const Text("Новости"),
                  CustomCarouselSlider(
                    items: newsToCarouselItem(snapshot.data!),
                    height: 300,
                    subHeight: 75,
                    width: 500,
                    autoplay: true,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

