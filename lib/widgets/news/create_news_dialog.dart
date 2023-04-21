import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/models/news.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/image_picker_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../components/custom_text_field.dart';
import '../error/error_dialog_view.dart';

class CreateNewsDialog extends StatefulWidget {
  News news;
  CreateNewsDialog(this.news);

  @override
  State<CreateNewsDialog> createState() => _CreateNewsDialogState();
}

class _CreateNewsDialogState extends State<CreateNewsDialog> {
  late News _news;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  XFile? selectedImage;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    this._news = widget.news;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (titleController.text.isEmpty && descriptionController.text.isEmpty) {
      titleController.text = _news.title;
      descriptionController.text = _news.description;
    }
    if (_news.id != 0 && selectedImage == null) {
      selectedImage = new XFile(_news.imageUrl);
    }
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
                ImagePickerView([selectedImage], imageCallback, 1),
                _news.id == 0 ?
                CustomButton(btnText: 'Создать', onTap: createNews, btnColor: Colors.green) :
                CustomButton(btnText: 'Сохранить', onTap: updateNews, btnColor: Colors.green)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void imageCallback(imgs){
    setState(() {
      selectedImage = imgs[0];
    });
  }
  Future<void> createNews() async {
    if (formKey.currentState!.validate()) {
      try {
        var title = titleController.text;
        var description = descriptionController.text;
        final httpImage = http.MultipartFile.fromBytes('news[image]', await selectedImage!.readAsBytes(), filename: selectedImage!.name);
        var news = new News.withFile(0, title, description, httpImage);
        context.read<NewsBloc>().add(
            CreateNewsEvent(news)
        );
        context.read<NewsBloc>().add(InitialNewsEvent());
        Navigator.of(context).pop();
      } catch (error) {
        var errorMessage = error.toString();
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
        );
      }
    }
  }
  Future<void> updateNews() async {
    if (formKey.currentState!.validate()) {
      try {
        _news.title = titleController.text;
        _news.description = descriptionController.text;
        _news.imageFile = http.MultipartFile.fromBytes('news[image]', await selectedImage!.readAsBytes(), filename: selectedImage!.name);
        context.read<NewsBloc>().add(UpdateNewsEvent(_news));
        context.read<NewsBloc>().add(InitialNewsEvent());
        Navigator.of(context).pop();
      } catch (error) {
        var errorMessage = error.toString();
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
        );
      }
    }
  }
}
