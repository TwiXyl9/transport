import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transport/blocs/cars_bloc.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/models/capacity.dart';
import 'package:transport/models/news.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/image_picker_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:transport/widgets/tail_type/tail_type_dropdown.dart';

import '../../models/car.dart';
import '../components/bold_text.dart';
import '../components/custom_text_field.dart';
import '../error/error_dialog_view.dart';

class CarDialog extends StatefulWidget {
  Car car;
  CarDialog(this.car);

  @override
  State<CarDialog> createState() => _CarDialogState();
}

class _CarDialogState extends State<CarDialog> {
  late Car _car;
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController numOfPalletsController = TextEditingController();
  TextEditingController loadCapacityController = TextEditingController();
  List<XFile?> selectedImages = [];
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    this._car = widget.car;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (_car.id != 0) {
      if (allIsEmpty()) {
        brandController.text = _car.brand;
        modelController.text = _car.model;
        priceController.text = _car.price.toString();

        widthController.text = _car.capacity.width.toString();
        heightController.text = _car.capacity.height.toString();
        lengthController.text = _car.capacity.length.toString();
        numOfPalletsController.text = _car.capacity.numOfPallets.toString();
        loadCapacityController.text = _car.capacity.loadCapacity.toString();
      }
      if (selectedImages.isEmpty) {
        selectedImages = _car.imagesUrls.map((e) => new XFile(e)).toList();
      }
    }
    return Dialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          constraints: BoxConstraints(minHeight: 200, maxHeight: MediaQuery.of(context).size.height, minWidth: 200, maxWidth: 500),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  BoldText("Основная информация"),
                  SizedBox(height: 20,),
                  CustomTextField(
                      controller: brandController,
                      hint: 'Брэнд',
                      type: FieldType.text,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'Заполните поле!';
                        }
                      }
                  ),
                  CustomTextField(
                      controller: modelController,
                      hint: 'Модель',
                      type: FieldType.text,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'Заполните поле!';
                        }
                      }
                  ),
                  CustomTextField(
                      controller: priceController,
                      hint: 'Цена за час',
                      type: FieldType.num,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'Введите значение!';
                        }
                      }
                  ),
                  SizedBox(height: 20,),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 20,),
                  BoldText("Технические характеристики"),
                  SizedBox(height: 20,),
                  CustomTextField(
                      controller: widthController,
                      hint: 'Ширина',
                      type: FieldType.num,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'Введите значение!';
                        }
                      }
                  ),
                  CustomTextField(
                      controller: heightController,
                      hint: 'Высота',
                      type: FieldType.num,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'Введите значение!';
                        }
                      }
                  ),
                  CustomTextField(
                      controller: lengthController,
                      hint: 'Длина',
                      type: FieldType.num,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'Введите значение!';
                        }
                      }
                  ),
                  CustomTextField(
                      controller: numOfPalletsController,
                      hint: 'Кол-во паллет',
                      type: FieldType.num,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'Введите значение!';
                        }
                      }
                  ),
                  CustomTextField(
                      controller: loadCapacityController,
                      hint: 'Грузоподъемность',
                      type: FieldType.num,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'Введите значение!';
                        }
                      }
                  ),
                  //TailTypeDropdown(types, value, callback);
                  SizedBox(height: 20,),
                  ImagePickerView(selectedImages, imageCallback, 10),
                  _car.id == 0 ?
                  CustomButton(btnText: 'Создать', onTap: createCar, btnColor: Colors.green) :
                  CustomButton(btnText: 'Сохранить', onTap: updateCar, btnColor: Colors.green)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void imageCallback(imgs){
    setState(() {
      selectedImages = imgs;
    });
  }

  Future<void> createCar() async {
    if (formKey.currentState!.validate()) {
      try {
        var brand = brandController.text;
        var model = modelController.text;
        var price = double.parse(priceController.text);

        var width = double.parse(widthController.text);
        var height = double.parse(heightController.text);
        var length = double.parse(lengthController.text);
        var numOfPallets = int.parse(numOfPalletsController.text);
        var loadCapacity = double.parse(loadCapacityController.text);
        final httpImages = await Future.wait(selectedImages!.map((e) async => http.MultipartFile.fromBytes('cars[images][]', await e!.readAsBytes(), filename: e.name)).toList());
        var car = new Car.withFiles(0, brand, model, price, httpImages, new Capacity(0, width, height, length, numOfPallets, loadCapacity));
        context.read<CarsBloc>().add(
            CreateCarEvent(car)
        );
        context.read<CarsBloc>().add(InitialCarsEvent());
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
  Future<void> updateCar() async {
    if (formKey.currentState!.validate()) {
      // try {
      //   widget.news.title = titleController.text;
      //   widget.news.description = descriptionController.text;
      //   widget.news.imageFile = http.MultipartFile.fromBytes('news[image]', await selectedImage!.readAsBytes(), filename: selectedImage!.name);
      //   context.read<NewsBloc>().add(UpdateNewsEvent(widget.news));
      //   context.read<NewsBloc>().add(InitialNewsEvent());
      //   Navigator.of(context).pop();
      // } catch (error) {
      //   var errorMessage = error.toString();
      //   showDialog(
      //       context: context,
      //       builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
      //   );
      // }
    }
  }
  bool allIsEmpty(){
    return brandController.text.isEmpty && modelController.text.isEmpty &&
        priceController.text.isEmpty && widthController.text.isEmpty &&
        heightController.text.isEmpty && lengthController.text.isEmpty &&
        numOfPalletsController.text.isEmpty && loadCapacityController.text.isEmpty;
  }
}
