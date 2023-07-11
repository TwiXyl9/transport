import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transport/widgets/components/custom_button.dart';

class ImagePickerView extends StatelessWidget {
  Function callback;
  int maxImages;
  List<XFile?> images;
  ImagePickerView(this.images, this.callback, this.maxImages);
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return FormBuilderImagePicker(
      name: 'photos',

      decoration: const InputDecoration(labelText: 'Фото'),
      maxImages: maxImages,
      initialValue: images,
      availableImageSources: kIsWeb? const [ImageSourceOption.gallery] : const [ImageSourceOption.gallery, ImageSourceOption.camera],
      validator: (v) {
        if (v!.isEmpty) {
          return 'Выберите фото';
        }
      },
      onChanged: (imagePath){
        if(imagePath!.length > 0) callback(List<XFile?>.from(imagePath!));
      },
    );
  }
}
