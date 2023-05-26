import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/page_header_text.dart';

import '../../models/news.dart';
import '../news/news_dialog.dart';

class NewsSlider extends StatelessWidget {
  List<News> allNews;
  NewsSlider(this.allNews);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            PageHeaderText(text: 'Новости'),
            SizedBox(height: 10,),
            CustomCarouselSlider(
              items: newsToCarouselItem(allNews),
              height: 300,
              subHeight: 75,
              width: 500,
              autoplay: false,
            ),
          ],
        ),
      ),
    );
  }
  List<CarouselItem> newsToCarouselItem(allNews) {
    List<CarouselItem> itemList = [];
    for (var i = 0; i < allNews.length; i++) {
      itemList.add(CarouselItem(
        image: NetworkImage(
          allNews[i].imageUrl,
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

}

