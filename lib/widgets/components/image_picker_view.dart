import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ImagePickerView extends StatelessWidget {
  Function callback;
  XFile? image;
  ImagePickerView(this.image, this.callback);
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return FormBuilderImagePicker(
      name: 'photos',
      decoration: const InputDecoration(labelText: 'Фото'),
      maxImages: 1,
      validator: (v) {
        if (v == null) {
          return 'Выберите фото';
        }
      },
      onChanged: (imagePath){
        callback(imagePath);
      },
    );
  }
  void pickImage() async {
    callback( await picker.pickImage(source: ImageSource.gallery));
  }
}