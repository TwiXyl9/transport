import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../blocs/additional_service_bloc.dart';
import '../../models/service.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../components/image_picker_view.dart';
import '../error/error_dialog_view.dart';

class AdditionalServiceDialog extends StatefulWidget {
  Service service;
  AdditionalServiceDialog(this.service);

  @override
  State<AdditionalServiceDialog> createState() => _AdditionalServiceDialogState();
}

class _AdditionalServiceDialogState extends State<AdditionalServiceDialog> {
  late Service _service;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? selectedImage;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _service = widget.service;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (_service.id != 0) {
      if (nameController.text.isEmpty && priceController.text.isEmpty) {
        nameController.text = _service.name;
        priceController.text = _service.price.toString();
      }
      if (_service.id != 0 && selectedImage == null) {
        selectedImage = new XFile(_service.imageUrl);
      }
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
                    controller: nameController,
                    hint: 'Название',
                    type: FieldType.text,
                    validator: (val) {
                      if(val!.isEmpty){
                        return 'Заполните название!';
                      }
                    }
                ),
                SizedBox(height: 20,),
                CustomTextField(
                    controller: priceController,
                    hint: 'Цена',
                    type: FieldType.num,
                    validator: (val) {
                      if(val!.isEmpty){
                        return 'Введите значение!';
                      }
                    }
                ),
                SizedBox(height: 20,),
                ImagePickerView([selectedImage], imageCallback, 1),
                _service.id == 0 ?
                CustomButton(btnText: 'Создать', onTap: createService, btnColor: Colors.green) :
                CustomButton(btnText: 'Сохранить', onTap: updateService, btnColor: Colors.green)
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
  Future<void> createService() async {
    if (formKey.currentState!.validate()) {
      try {
        var name = nameController.text;
        var price = double.parse(priceController.text);
        final httpImage = http.MultipartFile.fromBytes('service[image]', await selectedImage!.readAsBytes(), filename: selectedImage!.name);
        var service = new Service.withFile(0, name, price, httpImage);
        context.read<AdditionalServiceBloc>().add(
            CreateAdditionalServiceEvent(service)
        );
        context.read<AdditionalServiceBloc>().add(InitialAdditionalServiceEvent());
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
  Future<void> updateService() async {
    if (formKey.currentState!.validate()) {
      try {
        _service.name = nameController.text;
        _service.price = double.parse(priceController.text);;
        _service.imageFile = http.MultipartFile.fromBytes('service[image]', await selectedImage!.readAsBytes(), filename: selectedImage!.name);
        context.read<AdditionalServiceBloc>().add(UpdateAdditionalServiceEvent(_service));
        context.read<AdditionalServiceBloc>().add(InitialAdditionalServiceEvent());
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
