import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transport/widgets/news/admin_news_item_view.dart';
import 'package:transport/widgets/news/news_item_view.dart';

import '../../models/news.dart';

class NewsListView extends StatelessWidget {
  List<News> allNews;
  NewsListView(this.allNews);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Center(
        child: ListView(
          shrinkWrap: false,
          children: allNews.map((e) => NewsItemView(e)).toList()
        ),
      ),
    );
  }
}
