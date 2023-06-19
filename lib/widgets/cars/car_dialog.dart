import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:transport/blocs/cars_bloc.dart';
import 'package:transport/blocs/news_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/models/capacity.dart';
import 'package:transport/models/news.dart';
import 'package:transport/models/tail_type.dart';
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
  List<TailType> tailTypes;
  CarDialog(this.car, this.tailTypes);

  @override
  State<CarDialog> createState() => _CarDialogState();
}

class _CarDialogState extends State<CarDialog> {
  late Car _car;
  late List<TailType> _tailTypes;
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController pricePerHourController = TextEditingController();
  TextEditingController pricePerKilometerController = TextEditingController();

  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController numOfPalletsController = TextEditingController();
  TextEditingController loadCapacityController = TextEditingController();
  List<XFile?> selectedImages = [];
  final formKey = GlobalKey<FormState>();
  TailType selectedTailType = new TailType(0, '');
  @override
  void initState() {
    this._car = widget.car;
    this._tailTypes = widget.tailTypes;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (_car.id != 0) {
      if (allIsEmpty()) {
        brandController.text = _car.brand;
        modelController.text = _car.model;
        pricePerHourController.text = _car.pricePerHour.toString();
        pricePerKilometerController.text = _car.pricePerKilometer.toString();

        widthController.text = _car.capacity.width.toString();
        heightController.text = _car.capacity.height.toString();
        lengthController.text = _car.capacity.length.toString();
        numOfPalletsController.text = _car.capacity.numOfPallets.toString();
        loadCapacityController.text = _car.capacity.loadCapacity.toString();
        selectedTailType = _car.tailType;
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
                      controller: pricePerHourController,
                      hint: 'Цена за час',
                      type: FieldType.num,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'Введите значение!';
                        }
                      }
                  ),
                  CustomTextField(
                      controller: pricePerKilometerController,
                      hint: 'Цена за киллометр',
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
                  TailTypeDropdown(_tailTypes, selectedTailType, tailTypesCallback),
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
      print(selectedImages.length);
    });
  }
  tailTypesCallback(val){
    setState(() {
      selectedTailType = val;
    });
  }
  Future<void> createCar() async {
    if (formKey.currentState!.validate()) {
      try {
        var brand = brandController.text;
        var model = modelController.text;
        var pricePerHour = double.parse(pricePerHourController.text);
        var pricePerKilometer = double.parse(pricePerKilometerController.text);

        var width = double.parse(widthController.text);
        var height = double.parse(heightController.text);
        var length = double.parse(lengthController.text);
        var numOfPallets = int.parse(numOfPalletsController.text);
        var loadCapacity = double.parse(loadCapacityController.text);
        final httpImages = await Future.wait(selectedImages!.map((e) async => http.MultipartFile.fromBytes('car[images][]', await e!.readAsBytes(), filename: e.name)).toList());
        var car = new Car.withFiles(0, brand, model, pricePerHour, pricePerKilometer, httpImages, new Capacity(0, width, height, length, numOfPallets, loadCapacity), selectedTailType);
        context.read<CarsBloc>().add(CreateCarEvent(car));
        context.read<CarsBloc>().add(InitialCarsEvent(1));
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
      try {
        _car.brand = brandController.text;
        _car.model = modelController.text;
        _car.pricePerHour = double.parse(pricePerHourController.text);
        _car.pricePerKilometer = double.parse(pricePerKilometerController.text);

        _car.capacity.width = double.parse(widthController.text);
        _car.capacity.height = double.parse(heightController.text);
        _car.capacity.length = double.parse(lengthController.text);
        _car.capacity.numOfPallets = int.parse(numOfPalletsController.text);
        _car.capacity.loadCapacity = double.parse(loadCapacityController.text);
        print(selectedImages.length);
        _car.imagesFiles = await Future.wait(selectedImages!.map((e) async => http.MultipartFile.fromBytes('car[images][]', await e!.readAsBytes(), filename: e.name.isEmpty? path.basename(e.path) : e.name)).toList());
        print(_car.imagesFiles.length);
        context.read<CarsBloc>().add(UpdateCarEvent(_car));
        context.read<CarsBloc>().add(InitialCarsEvent(1));
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
  bool allIsEmpty(){
    return brandController.text.isEmpty && modelController.text.isEmpty &&
        pricePerHourController.text.isEmpty && pricePerKilometerController.text.isEmpty &&
        widthController.text.isEmpty && heightController.text.isEmpty &&
        lengthController.text.isEmpty && numOfPalletsController.text.isEmpty &&
        loadCapacityController.text.isEmpty;
  }
}
