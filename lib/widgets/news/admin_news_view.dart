import 'package:flutter/material.dart';
import 'package:transport/models/news.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/news/create_news_dialog.dart';
import 'package:transport/widgets/news/news_list_view.dart';

class AdminNewsView extends StatelessWidget {
  List<News> allNews;
  AdminNewsView(this.allNews);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SingleChildScrollView(
              child: NewsListView(allNews)
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: CustomButton(btnText: 'Добавить', onTap:() =>
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CreateNewsDialog(new News(0,'','',''));
                    }
                ),
                btnColor: Colors.green
            ),
          )
        ],
      ),
    );
  }
}
