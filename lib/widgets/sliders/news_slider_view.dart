import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:transport/blocs/news_bloc.dart';

class NewsSlider extends StatelessWidget {
  NewsSlider({super.key});
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
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      if (state is NewsInitial){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is NewsLoaded){
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Text("Новости"),
                CustomCarouselSlider(
                  items: newsToCarouselItem(state.news),
                  height: 300,
                  subHeight: 75,
                  width: 500,
                  autoplay: true,
                ),
              ],
            ),
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

