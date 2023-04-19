
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/models/news.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/error/error_dialog_view.dart';

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

    void updateNews(context){
      try {
        var bloc = context.read<NewsBloc>();
        bloc.add(UpdateNewsEvent(news));
        context.read<NewsBloc>().add(InitialNewsEvent());
      } catch (error) {
        var errorMessage = error.toString();
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
        );
      }
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 200,
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: Image.network(news.imageUrl)
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.bottomLeft,
                              height: 75,
                              width: 200,
                              decoration: BoxDecoration(
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
                              child: Text(news.title + '\n \n' + news.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CustomButton(btnText: "Редактировать", onTap: (){}, btnColor: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                right: -10,
                top: -9,
                child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.black.withOpacity(0.5),
                      size: 18,
                    ),
                    onPressed: () => deleteNews()
                )
            ),
          ],
        )
      ),
    );
  }
}
