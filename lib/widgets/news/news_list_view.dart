import 'package:flutter/material.dart';
import 'package:transport/widgets/news/admin_news_item_view.dart';

import '../../models/news.dart';

class NewsListView extends StatelessWidget {
  List<News> allNews;
  NewsListView(this.allNews);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: allNews.map((e) => AdminNewsItemView(e)).toList()
        ),
      ),
    );
  }
}
