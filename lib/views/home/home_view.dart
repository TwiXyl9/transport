import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/widgets/additional_info/advantages.dart';
import 'package:transport/widgets/additional_info/order_process.dart';
import 'package:transport/widgets/centered_view/centered_view.dart';
import 'package:transport/widgets/news/admin_news_view.dart';
import 'package:transport/widgets/order/order_button.dart';
import 'package:transport/widgets/news/news_slider_view.dart';

import '../../models/news.dart';
import '../../widgets/components/circular_add_button.dart';
import '../../widgets/components/custom_circular_progress_indicator.dart';
import '../../widgets/components/page_header_text.dart';
import '../../widgets/news/news_dialog.dart';
import '../layout_template/layout_template.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            print(state);
            return state is NewsLoadedState ?
                Column(
                  children: [
                    PageHeaderText(text: 'Новости'),
                    !state.user.isAdmin() ?
                    Column(
                      children: [
                        NewsSlider(state.news),
                        SizedBox(height: 20,),
                        OrderProcessWidget(),
                      ],
                    ) :
                    Column(
                      children: [
                        state.news.length > 0 ?
                        AdminNewsView(state.news) :
                        PageHeaderText(text: 'У компании пока нет услуг! Создайте первую!'),
                        CircularAddButton(() => {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NewsDialog(new News(0,'','',''));
                              }
                          ),
                        },)
                        ],
                    ),
                  ],
                ) :
            CustomCircularProgressIndicator();
          }
      ),
    );
  }
}
