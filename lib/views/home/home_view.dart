import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/widgets/additional_info/advantages.dart';
import 'package:transport/widgets/news/admin_news_view.dart';
import 'package:transport/widgets/order/order_button.dart';
import 'package:transport/widgets/sliders/news_slider_view.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: [
                    state is NewsLoadedState ? state.user.id! == 0 ? NewsSlider(state.news) : AdminNewsView(state.news) : CircularProgressIndicator(),
                  ],
                ),
              ),

              state is NewsLoadedState ? state.user.id! == 0 ? Container(
                  alignment: Alignment.bottomRight,
                  child: OrderButton(context)
              ) : Container()  : CircularProgressIndicator(),
            ],
          );
        }
    );
  }
}
