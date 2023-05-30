import 'package:flutter/material.dart';
import 'package:transport/models/news.dart';
import 'package:transport/widgets/components/circular_add_button.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/news/admin_news_item_view.dart';
import 'package:transport/widgets/news/news_dialog.dart';
import 'package:transport/widgets/news/news_item_view.dart';
import 'package:transport/widgets/news/news_list_view.dart';

class AdminNewsView extends StatelessWidget {
  List<News> allNews;
  AdminNewsView(this.allNews);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 500,
            child: ListView(
                shrinkWrap: true,
                children: allNews.map((e) => AdminNewsItemView(e)).toList()
            ),
          ),
        ),
        CircularAddButton(() => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return NewsDialog(new News(0,'','',''));
              }
          ),
        },)
      ],
    );
  }
}
