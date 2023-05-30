import 'package:flutter/material.dart';
import 'package:transport/models/news.dart';

class NewsItemView extends StatelessWidget {
  final News news;
  NewsItemView(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(news.imageUrl, fit: BoxFit.cover, width: 500, height: 300,),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
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
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      Text(
                        news.title ,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(),
                      Text(
                        news.description ,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
