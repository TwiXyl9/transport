
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/models/news.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/error/error_dialog_view.dart';

import 'news_dialog.dart';
import 'news_item_view.dart';

class AdminNewsItemView extends StatelessWidget {
  final News news;
  AdminNewsItemView(this.news);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<NewsBloc>(context);
    void deleteNews(){
      try {
        bloc.add(DeleteNewsEvent(news));
        bloc.add(InitialNewsEvent());
      } catch (error) {
        var errorMessage = error.toString();
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
        );
      }
    }
    return Card(
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              NewsItemView(news),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return NewsDialog(news);
                            }
                        );
                      },
                      icon: Icon(Icons.edit)
                  ),
                  SizedBox(width: 10,),
                  IconButton(
                      onPressed: deleteNews,
                      icon: Icon(Icons.delete)
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}
