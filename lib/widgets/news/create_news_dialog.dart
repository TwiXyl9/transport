import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/news_bloc.dart';

class CreateNewsDialog extends StatelessWidget {
  const CreateNewsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsBloc, NewsState>(
        listener: (context, state) {
          if(state is NewsFailureState){
            print(state.error);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Что-то пошло не так..."),
                backgroundColor: Theme
                    .of(context)
                    .errorColor,
              ),
            );
          }
        },
        child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight:200, maxHeight: MediaQuery.of(context).size.height, minWidth: 200, maxWidth: 800),
                  child: Text("Hello"),
                ),
              ),
            ),
          );
        }
    )
    );
  }
}
