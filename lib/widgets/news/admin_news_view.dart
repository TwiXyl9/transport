import 'package:flutter/material.dart';
import 'package:transport/models/news.dart';
import 'package:transport/widgets/components/circular_add_button.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/news/news_dialog.dart';
import 'package:transport/widgets/news/news_list_view.dart';

class AdminNewsView extends StatelessWidget {
  List<News> allNews;
  AdminNewsView(this.allNews);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NewsListView(allNews),
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            margin: EdgeInsets.all(20),
            child: CircularAddButton(() => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewsDialog(new News(0,'','',''));
                  }
              ),
            },)
          ),
        )
      ],
    );
  }
}
