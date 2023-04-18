import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/image_picker_view.dart';

import '../components/custom_text_field.dart';

class CreateNewsDialog extends StatefulWidget {
  const CreateNewsDialog({Key? key}) : super(key: key);

  @override
  State<CreateNewsDialog> createState() => _CreateNewsDialogState();
}

class _CreateNewsDialogState extends State<CreateNewsDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  XFile? image;
  final formKey = GlobalKey<FormState>();
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
              child: Container(
                constraints: BoxConstraints(minHeight: 200, maxHeight: MediaQuery.of(context).size.height, minWidth: 200, maxWidth: 500),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: titleController,
                          hint: 'Заголовок',
                          type: FieldType.text,
                          validator: (val) {
                            print(val!.isEmpty);
                            if(val!.isEmpty){
                              return 'Заполните заголовок!';
                            }
                          }
                      ),
                      SizedBox(height: 20,),
                      CustomTextField(
                          controller: descriptionController,
                          hint: 'Описание',
                          type: FieldType.text,
                          validator: (val) {
                            if(val!.isEmpty){
                              return 'Заполните описание!';
                            }
                          }
                      ),
                      SizedBox(height: 20,),
                      ImagePickerView(image, imageCallback),
                      CustomButton(btnText: 'Создать', onTap: createNews)
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }

  void imageCallback(img){
    setState(() {
      image = img;
    });
  }
  void createNews(){
    if (formKey.currentState!.validate()) {

    }
  }
}
