import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/page_header_text.dart';

class OrderProcessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> steps = [
      _buildStepBlock('1', 'Создание заявки', 'Пользователь создает новую заявку, указывая информацию о грузе, маршруте и требованиях.'),
      _buildArrow(),
      _buildStepBlock('2', 'Подтверждение заявки', 'Компания проверяет заявку и подтверждает ее, общаясь с пользователем для уточнения деталей.'),
      _buildArrow(),
      _buildStepBlock('3', 'Назначение транспорта', 'Компания выбирает подходящий транспорт и назначает его для выполнения грузоперевозки.'),
      _buildArrow(),
      _buildStepBlock('4', 'Выполнение грузоперевозки', 'Загрузка груза, транспортировка в указанное место и разгрузка на месте назначения.'),
      _buildArrow(),
      _buildStepBlock('5', 'Подтверждение выполнения', 'Пользователь подтверждает выполнение заказа, оценивает качество услуг и оставляет отзыв.'),
    ];
    return Column(
      children: [
        PageHeaderText(text: 'Шаги выполнения заказа'),
        Container(
            width: MediaQuery.of(context).size.width,
            height: kIsWeb? 170 : double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: kIsWeb? ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: steps,
            ) : Column(children: steps,)
        ),
      ],
    );
  }

  Widget _buildStepBlock(String stepNumber, String title, String description) {
    return Container(
      width: 250,
      height: 170,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Шаг $stepNumber',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return Icon(
      kIsWeb? Icons.arrow_forward : Icons.arrow_downward,
      size: 40,
      color: Colors.white,
    );
  }
}