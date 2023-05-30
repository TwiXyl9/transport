import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/news.dart';
import 'news_item_view.dart';

class NewsSlider extends StatefulWidget {
  List<News> allNews;
  NewsSlider(this.allNews);

  @override
  State<StatefulWidget> createState() {
    return _NewsSliderState();
  }
}

class _NewsSliderState extends State<NewsSlider> {
  int _current = 0;
  late List<News> _news;
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    _news = widget.allNews;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Container(
              width: 500,
              height: 300,
              child: CarouselSlider(
                items: _news.map((e) => NewsItemView(e)).toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _news.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ]
    );
  }
}

