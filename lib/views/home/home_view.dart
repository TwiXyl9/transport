import 'package:flutter/material.dart';
import 'package:transport/widgets/additional_info/advantages.dart';
import 'package:transport/widgets/sliders/news_slider_view.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewsSlider(),
        const AdvantagesView(),
      ],
    );
  }
}
