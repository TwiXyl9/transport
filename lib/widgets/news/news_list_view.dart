import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transport/widgets/news/admin_news_item_view.dart';

import '../../models/news.dart';

class NewsListView extends StatelessWidget {
  List<News> allNews;
  NewsListView(this.allNews);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(minWidth: 300, maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: StaggeredGrid.count(
            crossAxisCount: kIsWeb? MediaQuery.of(context).size.width > 900 ? 3 : 2 : 1,
            children: allNews.map((e) => AdminNewsItemView(e)).toList()
          ),
        ),
      ),
    );
  }
}
