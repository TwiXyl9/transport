import 'package:flutter/material.dart';
import 'package:transport/models/news.dart';
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
        Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.all(20),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green,
            child: IconButton(
                onPressed: () => {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NewsDialog(new News(0,'','',''));
                      }
                  ),
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                   size: 25,
                )
            ),
          )
        )
      ],
    );
  }
}
