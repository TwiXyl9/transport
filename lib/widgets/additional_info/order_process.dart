import 'package:flutter/material.dart';

class OrderProcessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: false,
          crossAxisCount: 1,
          children: [
            _buildStepBlock('1', 'Создание заявки', 'Пользователь создает новую заявку, указывая информацию о грузе, маршруте и требованиях.'),
            _buildArrow(),
            _buildStepBlock('2', 'Подтверждение заявки', 'Компания проверяет заявку и подтверждает ее, общаясь с пользователем для уточнения деталей.'),
            _buildArrow(),
            _buildStepBlock('3', 'Назначение транспорта', 'Компания выбирает подходящий транспорт и назначает его для выполнения грузоперевозки.'),
            _buildArrow(),
            _buildStepBlock('4', 'Выполнение грузоперевозки', 'Загрузка груза, транспортировка в указанное место и разгрузка на месте назначения.'),
            _buildArrow(),
            _buildStepBlock('5', 'Подтверждение выполнения', 'Пользователь подтверждает выполнение заказа, оценивает качество услуг и оставляет отзыв.'),
          ],
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     _buildStepBlock('1', 'Создание заявки', 'Пользователь создает новую заявку, указывая информацию о грузе, маршруте и требованиях.'),
      //     _buildArrow(),
      //     _buildStepBlock('2', 'Подтверждение заявки', 'Компания проверяет заявку и подтверждает ее, общаясь с пользователем для уточнения деталей.'),
      //     _buildArrow(),
      //     _buildStepBlock('3', 'Назначение транспорта', 'Компания выбирает подходящий транспорт и назначает его для выполнения грузоперевозки.'),
      //     _buildArrow(),
      //     _buildStepBlock('4', 'Выполнение грузоперевозки', 'Загрузка груза, транспортировка в указанное место и разгрузка на месте назначения.'),
      //     _buildArrow(),
      //     _buildStepBlock('5', 'Подтверждение выполнения', 'Пользователь подтверждает выполнение заказа, оценивает качество услуг и оставляет отзыв.'),
      //   ],
      // ),
    );
  }

  Widget _buildStepBlock(String stepNumber, String title, String description) {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
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
      Icons.arrow_forward,
      size: 40,
      color: Colors.grey[500],
    );
  }
}